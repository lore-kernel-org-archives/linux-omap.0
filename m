From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2 2/5] ARM: edma: Get IP information from HW when booting
 with DT
Date: Fri, 16 May 2014 12:31:27 -0500
Message-ID: <53764B6F.9030106@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com> <1399977032-26469-3-git-send-email-peter.ujfalusi@ti.com> <53748070.4080706@ti.com> <5374B34D.2060904@ti.com> <5374B7B8.4060604@ti.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5374B7B8.4060604@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/15/2014 07:48 AM, Sekhar Nori wrote:
> On Thursday 15 May 2014 06:00 PM, Peter Ujfalusi wrote:
> 
>> The second controller is not handled because in DT boot we only handle 1 cc as
>> far as I know. I don't know why, but this is how the DT support has been
>> written and used.
> 
> Its just because none of the platforms under heavy development use two
> controllers. Joel promised to work on it at some point ;)

Yeah, often things like that go down in priority when there aren't
users, and when other things on fire need to be tended to :-D

I think the next on-fire thing as far as EDMA goes would be to move out
into drivers/edma. I like Peter's series in that it probably is a step
forward there.

thanks,

-Joel

