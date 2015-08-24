From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFT PATCH] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Mon, 24 Aug 2015 22:24:42 +0100
Message-ID: <20150824212442.GI7576@n2100.arm.linux.org.uk>
References: <1439892601-19306-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439892601-19306-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 18, 2015 at 03:40:01PM +0530, Keerthy wrote:
> Currently apart from dra7, omap5 and amx3 all the other SoCs
> are identified using cpu_is_* functions which is not right since
> they are all SoCs(System on Chips). Hence changing the SoC
> identific=E4tion code to use soc_is instead of cpu_is and keeping
           ^
typo

> defines for cpu_is where needed. This allows us to replace the
> rest of cpu_is usage along with other fixes as needed.

Good to see this change to a more sensible naming of these, despite
the obvious churn.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
