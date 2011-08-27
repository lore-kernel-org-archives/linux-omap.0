From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 09:07:46 -0700
Message-ID: <20110827160746.GA11076@kroah.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
	<CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 27, 2011 at 11:33:26PM +0800, Ming Lei wrote:
> Hi,
> =

> On Sat, Aug 27, 2011 at 11:13 PM, Greg KH <greg@kroah.com> wrote:
> > On Sat, Aug 27, 2011 at 10:48:35PM +0800, ming.lei@canonical.com wrote:
> >> From: Ming Lei <ming.lei@canonical.com>
> >>
> >> This patch fixs one performance bug on ARM Cortex A9 dual core platfor=
m,
> >> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, sn=
owball...),
> >> see details from link of https://bugs.launchpad.net/bugs/709245.
> >>
> >> In fact, one mb() on ARM is enough to flush L2 cache, but
> >> 'dummy->hw_token =3D token;' after mb() is added just for obeying
> >> correct mb() usage.
> >
> > Really? =A0A mb() should not be flushing any caches, it's just a memory
> > barrier. =A0Or is ARM somehow "special" in this way?
> =

> As Santosh pointed out, mb on ARM will flush L2 write buffer. The
> description here is wrong.

Then this can't be accepted as-is :)

> I think the below should make the writing reach into memory on all
> ARCH after ' token =3D dummy->hw_token;' is executed.
> =

>                        dummy->hw_token =3D token;
>                        mb()
>                        token =3D dummy->hw_token;
> =

> The above is the idea introduced to fix the problem.

Are you sure?  Have you read the documentation about memory barriers to
confirm this?

> >> The patch has been tested ok on OMAP4 panda A1 board, the performance
> >> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
> >> 14~16MB/sec after applying this patch.
> >
> > That's impressive, but I don't think this is really the proper way to do
> > this...
> >
> >> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> >> ---
> >> =A0drivers/usb/host/ehci-q.c | =A0 14 ++++++++++++++
> >> =A01 files changed, 14 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> >> index 0917e3a..65b5021 100644
> >> --- a/drivers/usb/host/ehci-q.c
> >> +++ b/drivers/usb/host/ehci-q.c
> >> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb ();
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy->hw_token =3D token;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The mb() below is added t=
o make sure that
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 'token' can be writen i=
nto qtd, so that ehci
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* HC can see the up-to-da=
te qtd descriptor. On
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* some archs(at least on =
ARM Cortex A9 dual core),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* writing into coherenet =
memory doesn't mean the
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value written can reach=
 physical memory
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* immediately, and the va=
lue may be buffered
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* inside L2 cache. 'dummy=
->hw_token =3D token;'
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after mb() is added for=
 obeying correct mb()
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* usage.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mb();
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D dummy->hw_token;
> >
> > Your comment does not match the code, so something is wrong here.
> =

> If you mean "L2 cache flush", I confess to the mistaken description,
> and will update it later. If you mean others, could you help to point it =
out?

I mean others, please read the the last 3 lines of the comment and
compare that to the code lines you added.

greg k-h
