From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Tue, 9 Feb 2016 13:49:13 +0100
Message-ID: <56B9E049.5080700@baylibre.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
 <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
 <20160201132228.2634b72e.drivshin.allworx@gmail.com>
 <20160201185952.GN19432@atomide.com> <20160202162330.GA4918@ulmo>
 <20160202184443.1e1b0bf5.drivshin.allworx@gmail.com>
 <20160203141454.GC9650@ulmo>
 <20160205145146.34ec4eb9.drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20160205145146.34ec4eb9.drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 02/05/2016 08:51 PM, David Rivshin (Allworx) wrote:
> 
> Either way, I think any changes along these lines would probably be 
> cleaner ontop of the atomic update work (assuming some form of that 
> gets merged). And since it would also be outside the scope of this 
> patchset, you may still want to consider the simple debug message 
> in this patch as at least an interim state.
> 

Sure, we should push these patches and rework this one later.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
