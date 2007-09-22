From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: GP-timers for 2430
Date: Sat, 22 Sep 2007 05:23:56 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701D27E22@dlee13.ent.ti.com>
References: <c656a4d20709210025r7b6e418ejadc4ae3876cf3fe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20709210025r7b6e418ejadc4ae3876cf3fe1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of arun c
>Sent: Friday, September 21, 2007 2:25 AM
>To: linux-omap-open-source@linux.omap.com
>Subject: GP-timers for 2430
>
>Hi all,
>
>I am working on 2430 sdp (linux 2.6.19 custom kernel).
>
>I want to use gptimer 5 and 6 for my application.
>
>Whether i have to enable GPtimer 5&6 in xloader or  I have to do it in
>kernel?
>
>I tried enabling them in /arch/arm/mach-omap2/timer-gp.c like this
>

I think you should use dmtimer APIs exported by =
arch/arm/plat-omap/dmtimer.c

They have all the necessary APIs to configure and use OMAP2 GP timers.

Regards,
Khasim
