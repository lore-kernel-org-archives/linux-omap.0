From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Mon, 1 Oct 2007 11:06:26 -0700
Message-ID: <20071001180626.GN24656@atomide.com>
References: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
	<46F1450E.8020307@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F1450E.8020307@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070919 08:50]:
> Lu=EDs Cargnini wrote:
>> --- linux-omap-2.6/arch/arm/plat-omap/devices.c 2007-08-28 01:01:
>> 50.502065325 -0300
>> +++ linux-omap-2.6.23-instramed/arch/arm/plat-omap/devices.c    2007-0=
9-18
>> 15:05:44.748685528 -0300
> ...
>
> Should this be a fix for your issues [1]?
>
> If yes, why do you think [2] isn't sufficent? Did you try [2]?
>
> [3] introduced usage of OMAP2_CTRL_BASE undefined on OMAP1. So anything=
=20
> like [2] to fix compilation issues like [1] should be sufficent to fix =
[1].=20
> [2] works at least for me selecting MMC on OSK.

Luis, please repost your patch if something still needs to be patched.

Tony



> [1]=20
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/0=
11373.html
>
> [2]=20
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/0=
11393.html
>
> [3]=20
> http://source.mvista.com/git/?p=3Dlinux-omap-2.6.git;a=3Dcommitdiff;h=3D=
ad1794683d378d08467ea9b340628994ff3e7edd
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
