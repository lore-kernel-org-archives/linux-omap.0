From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract regulator_init_data
Date: Thu, 20 Oct 2011 09:12:10 +0530
Message-ID: <4E9F9892.9070007@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com> <1318263578-7407-4-git-send-email-rnayak@ti.com> <20111016145536.GA29885@S2100-06.ap.freescale.net> <4E9BAC4D.3010402@ti.com> <20111018115836.GC30703@S2100-06.ap.freescale.net> <20111018160046.GD28501@opensource.wolfsonmicro.com> <20111019053354.GB31162@S2100-06.ap.freescale.net> <20111019144734.GI18713@sirena.org.uk> <20111019150448.GB32007@S2100-06.ap.freescale.net> <20111019151031.GA4275@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111019151031.GA4275@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 19 October 2011 08:40 PM, Mark Brown wrote:
> The problem is that the DT is supposed to be separate to the kernel and
> the decisions can depend on what the kernel is currently capable of.
> When the data is embedded in the kernel it's not an issue as the data is
> attached to the rest of the code, when the data becomes detatched from
> the kernel it becomes an issue.

completely agreed.

>
> I don't see any issue with leaving some things out of the DT bindings;
> you were the one raising that as a concern.

The problem is, that there doesn't seem to be a clean way to embed
*board data* into the kernel with DT, if left out of the DT bindings.
There is the auxdata way of still attaching platform_data, but that I
thought was a stopgap for just handling function pointers.
