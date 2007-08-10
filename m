From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] Add kfifo_get_to_user to copy data to userland
	directly
Date: Fri, 10 Aug 2007 02:20:02 -0700
Message-ID: <20070810092001.GJ8658@atomide.com>
References: <11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
	<5d5443650708060631y7e14b285ve475a4f4f28fbad8@mail.gmail.com>
	<20070807.125855.68055973.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070807.125855.68055973.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [070807 04:19]:
> From: "ext Trilok Soni" <soni.trilok@gmail.com>
> Subject: Re: [PATCH 4/8] Add kfifo_get_to_user to copy data to userland directly
> Date: Mon, 6 Aug 2007 19:01:10 +0530
> 
> > Hi Doyu-San,
> > 
> > On 7/30/07, Hiroshi.DOYU@nokia.com <Hiroshi.DOYU@nokia.com> wrote:
> > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >
> > > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > ---
> > >  include/linux/kfifo.h |   35 ++++++++++++++++++++++++++++++
> > >  kernel/kfifo.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 92 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> > > index 404f446..2dd610d 100644
> > > --- a/include/linux/kfifo.h
> > > +++ b/include/linux/kfifo.h
> > > @@ -43,6 +43,9 @@ extern unsigned int __kfifo_put(struct kfifo *fifo,
> > >                                 unsigned char *buffer, unsigned int len);
> > >  extern unsigned int __kfifo_get(struct kfifo *fifo,
> > >                                 unsigned char *buffer, unsigned int len);
> > > +extern unsigned int __kfifo_get_to_user(struct kfifo *fifo,
> > > +                                       unsigned char __user *buffer,
> > > +                                       unsigned int len);
> > >
> > 
> > Thanx. Finally that local fifo implementation is gone. Could you
> > please submit this patch to LKML also?
> 
> I got it. In that case, "__kfifo_put_from_user()" may be also necessary.

Pushing the series today. Yeah, please send the kfifo patches to LKML
for review and integration.

Regards,

Tony
