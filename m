From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: edma: Clean up and simplify the code around irq
 request
Date: Thu, 15 May 2014 17:35:01 +0530
Message-ID: <5374AD6D.8090002@ti.com>
References: <1399965961-23739-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399965961-23739-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

+ ARM SoC team

On Tuesday 13 May 2014 12:56 PM, Peter Ujfalusi wrote:
> Get the two interrupt line number at the same time by merging the two
> instance of if(node){}else{} places.
> replace the &pdev->dev with the already existing dev which makes it possible
> to collapse lines with devm_request_irq()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Arnd, Olof, Kevin,

Do you mind applying this directly for v3.16? I do not have anything
else queued ATM so not sending a pull request.

Thanks,
Sekhar
