From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RFC: 3430 USB support
Date: Thu, 6 Dec 2007 12:25:38 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08075E7BB@dbde01.ent.ti.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804F64BA1@dbde01.ent.ti.com>
	<87ir3c52g2.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <87ir3c52g2.fsf@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, David Brownell <david-b@pacbell.net>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


Hi Kevin/Tony/David/3430-USB-interested-group

As far as USB on 3430 is concerned, following is the difference between =
3430 ES1.0 and 3430ES2.0:

3430 ES1.0:
	USB Core1: MUSB(old) + ISP1504=20
	USB Core2: FS-OHCI + FS-OTG + FS-DEV (old - Legacy 2430 way)

3430 ES 2.0:
	USB Core1	: MUSB(old)+ T2-Transceiver(NEW)
	USB Core2	: EHCI/OHCI block (NEW) <---------- All new replacing old =
block

USB Core1 MUSB:=20
We should be able to get MUSB working for both ES1.0 and ES2.0 as there =
is no extra programming required for the ULPI transceivers. Only the =
transceiver is changing from ISP1504 to T2.
So Kevin we will look into the issue you reported of MUSB not working on =
ES1.0

USB Core2:=20
The tricky part is the USB Core2. It is completely replacing the =
Full-speed OHCI block on ES2.0
What we are planning is that for 3430, we will support only the ES2.0 =
and not complicate things for the Core2. Is that fine?=20

Also I am not sure how many people are using the ES1.0 version?=20

Regards,
Vikram Pandita
