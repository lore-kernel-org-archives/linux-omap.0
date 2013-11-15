From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3] ARM: OMAP2+: omap_device: maintain sane runtime pm
 status around suspend/resume
Date: Fri, 15 Nov 2013 20:04:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311152002500.25958@utopia.booyaka.com>
References: <1384297710-29694-1-git-send-email-nm@ti.com> <1384448716-3186-1-git-send-email-nm@ti.com> <alpine.DEB.2.02.1311150806220.15980@utopia.booyaka.com> <528621E5.4030201@ti.com> <20131115143736.GW10317@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131115143736.GW10317@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, rnayak@ti.com, khilman@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 15 Nov 2013, Tony Lindgren wrote:

> I can take it unless you have other fixes pending right now.

Ran a quick test with the patch applied on v3.12, results here:

http://www.pwsan.com/omap/testlogs/test_nm_omap_device_fix_v3.12-rc/20131115123132/

No other fixes queued here right now, so:

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
