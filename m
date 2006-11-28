From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] To enable I2C-2 for 2430 SDP
Date: Mon, 27 Nov 2006 20:11:16 -0800
Message-ID: <20061128041116.AF1DF1E1922@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <456B3E4C.2060300@gmail.com>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01F7E909@DLEE09.ent.ti.com>
	<20061128022310.GB7763@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061128022310.GB7763@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: x0khasim@ti.com, tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On H4, J15 is used for the TUSB 6010 EVM, either for the chip IRQ or
the DMA request (depending on cpu board version), instead of I2C2_SCL.

Eventually there should be a way to configure whether a given board
uses I2C1, I2C2, or both.

- Dave
