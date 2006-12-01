From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: MMC not working on Z71
Date: Fri, 1 Dec 2006 07:00:17 +0100
Message-ID: <200612010700.17693.marek.vasut@gmail.com>
References: <200611270016.04977.marek.vasut@gmail.com>
	<20061130223920.GB9605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061130223920.GB9605@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dne =C4=8Dtvrtek 30 listopad 2006 23:39 jste napsal(a):
> * Marek Va=C5=A1ut <marek.vasut@gmail.com> [061126 15:17]:
> > Hi,
> > since this commit
> > http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcomm=
it;h=3D3
> >6808520ce2c9ade647d36c80004c158c71d0510 MMC on palmz71 stopped working.
> > With latest git it doesnt even get inited. When I enable debug I get cm=
d3
> > timeout. I find out that when I compile initramfs into kernel and try
> > mounting mmc partition, the kernel tries to init the card (I get that
> > MMC: something and mmc: p1 p2 etc. [sorry, I dont remember it exactly, I
> > can give more details, if you need them, just ask]) but fails with a lot
> > of io errors about probs with reading mmc block 0. And that=C2=B4s the =
end.
> > Weird is, that mmc was working with 2618-omap1, but after that sync with
> > Linuses tree it just suddenly stopped. The diff against those 2 commits
> > is 32megs, so it=C2=B4s quite a prob to find what damaged the mmc. Also=
, it=C2=B4s
> > weird that mmc works on palmte. Can this be prob, that mmc isnt powered
> > up? I doubt so though.
>
> Yeah, that a big patch :) Have you tried just undoing the mmc parts in th=
at
> patch and see if that helps to narrow down the problem?
>
> Regards,
>
> Tony

Sure ;) I removed all patches for mmc but one - mmc-block.c.diff - which wa=
s=20
too complexly integrated into the kernel. But it didnt helped though :( btw=
=2E=20
yeah ... it is a bigger patch ;D

BR
Marex
