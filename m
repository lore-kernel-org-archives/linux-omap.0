From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: AM3517EVM: remove check for
 CONFIG_PANEL_SHARP_LQ043T1DG01
Date: Fri, 16 May 2014 14:13:21 -0700
Message-ID: <20140516211321.GG12881@atomide.com>
References: <1400183692.11786.23.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400183692.11786.23.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [140515 12:55]:
> The Kconfig symbol PANEL_SHARP_LQ043T1DG01 was removed in v2.6.38. The
> check for CONFIG_PANEL_SHARP_LQ043T1DG01 and its MODULE variant has
> evaluated to false ever since. Remove that check.

Thanks applying into omap-for-v3.16/board.

Tony
