From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 1/12] Add VFP support for ARM V7 - OMAP 3430 support
Date: Thu, 31 May 2007 16:58:05 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701063467@dlee13.ent.ti.com>
References: <465F3F42.1020805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <465F3F42.1020805@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

>Sorry to not speak up sooner, but I think we need to rebase this whole
>patchset on top of Catalin's ARMv7 patches which he has in his tree[1]
>
Similar comment was passed by Trilok.=20

I understand what you guys are trying to communicate but still I would =
like to base our Cortex development for OMAP tree on =
Patch-2.6.19-arm2.gz from http://www.arm.com/linux/linux_download.html.=20

The reason is, AFAIK, this snapshot was tested by ARM on different ARM =
platforms. We can pull stuff from ARM's GIT but then I don't know how =
far they are being tested on other ARM platforms. Basically it will be =
difficult to test all ARM platforms from our end, I am anyway testing my =
patches on 2420, 2430, 3430 now.

We have a limited interest for Cortex developments on OMAP GIT. I think =
for now we are satisfied if it works to an extent where we could get all =
our 3430 drivers on OMAP GIT. In the mean time Cortex support might be =
improved on RMK's tree. If we find something missing/important then we =
can pull only that on OMAP GIT.

We can discuss with Catalin and get his views on the same.

Thanks.

Regards,
Khasim
