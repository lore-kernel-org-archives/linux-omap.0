From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3
 dcdc5 and dcdc6 enable during suspend
Date: Tue, 21 Jun 2016 04:46:06 -0700
Message-ID: <20160621114606.GU22406@atomide.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466412218-5906-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [160620 01:46]:
> dcdc3, dcdc5, dcdc6 supply ddr and rtc respectively. These
> are required to be on during suspend. Hence set the state accordingly.

Actually, please fix up the subject lines for the dts patches too :)

Instead of "ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make..."
how about something like "ARM: dts: Allow dcdc enable during
suspend for am43xx"?

Regards,

Tony
