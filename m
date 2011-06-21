From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keypad: lm8323: use level triggered interrupts
Date: Tue, 21 Jun 2011 04:26:14 -0700
Message-ID: <20110621112613.GB12114@core.coreip.homeip.net>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
 <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
 <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
 <694a51cff83de55276b804b23668447e@doppler.thel33t.co.uk>
 <20110620082605.GE14262@legolas.emea.dhcp.ti.com>
 <3f659cd53ac25c98701c2bb3a453ab06@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f659cd53ac25c98701c2bb3a453ab06@doppler.thel33t.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: balbi@ti.com, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2011 at 08:02:27PM +0100, Leigh Brown wrote:
> This patch, which should be applied on top of Felipe's
> "input: keypad: lm8323: convert to threaded IRQ" patch, fixes the issue
> of the Nokia N810 keypad stopping responding if multiple key events
> occur
> in quick succession.
> 
> Signed-off-by: Leigh Brown <leigh@solinno.co.uk>

Applied, thanks Leigh.

-- 
Dmitry
