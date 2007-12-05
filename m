From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: Patches adding TWL4030 USB support and MUSB
	support on 34xx
Date: Wed, 5 Dec 2007 18:37:40 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804F64BA1@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

This series of patches adds support for MUSB on 34xx.

Tested on OMAP 3430. Compile and boot tested on 2430.

Notes:

Enabling CONFIG_USB_MUSB_OTG selects CONFIG_PM. This was enabled in a
previous patch sent by Sameer [1].

Tony said he was pushing this but it appears to have been left out.
My patches assume that PM support for OMAP 34xx is enabled.

Regards,
Anand

[1] Re: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Sent by Tony Lindgren on 11/29/2007
