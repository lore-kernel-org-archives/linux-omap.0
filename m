From: tony@atomide.com
Subject: Re: MMC not working on Z71
Date: Thu, 30 Nov 2006 14:39:21 -0800
Message-ID: <20061130223920.GB9605@atomide.com>
References: <200611270016.04977.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611270016.04977.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061126 15:17]:
> Hi,
> since this commit
> http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcomm=
it;h=3D36808520ce2c9ade647d36c80004c158c71d0510
> MMC on palmz71 stopped working. With latest git it doesnt even get init=
ed.=20
> When I enable debug I get cmd3 timeout. I find out that when I compile=20
> initramfs into kernel and try mounting mmc partition, the kernel tries =
to=20
> init the card (I get that MMC: something and mmc: p1 p2 etc. [sorry, I =
dont=20
> remember it exactly, I can give more details, if you need them, just as=
k])=20
> but fails with a lot of io errors about probs with reading mmc block 0.=
 And=20
> that=C2=B4s the end. Weird is, that mmc was working with 2618-omap1, bu=
t after=20
> that sync with Linuses tree it just suddenly stopped. The diff against =
those=20
> 2 commits is 32megs, so it=C2=B4s quite a prob to find what damaged the=
 mmc. Also,=20
> it=C2=B4s weird that mmc works on palmte. Can this be prob, that mmc is=
nt powered=20
> up? I doubt so though.

Yeah, that a big patch :) Have you tried just undoing the mmc parts in th=
at
patch and see if that helps to narrow down the problem?

Regards,

Tony
