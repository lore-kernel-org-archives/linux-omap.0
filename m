From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: omap 2430 sdp - reboot doesnt work.
Date: Wed, 2 May 2007 20:17:50 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47D0225A@dlee13.ent.ti.com>
References: <c04186510705021004o6baad54dp2319fcbb18978b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510705021004o6baad54dp2319fcbb18978b63@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Sandeep,

>Reboot command does not work on omap 2430 SDP. It just hangs.
>
>Im using 2.6.14 Linux kernel sources.
>
>Do we have a patch/how does one fix it?

We had similar issues before. It's fixed in the latest tar ball uploaded =
on linux.omap.com

Take a diff of these files:

2.6_kernel/arch/arm/mach-omap2/clock24xx.c
2.6_kernel/arch/arm/mach-omap2/Makefile
2.6_kernel/include/asm-arm/arch-omap/system.h

Regards,
Khasim
