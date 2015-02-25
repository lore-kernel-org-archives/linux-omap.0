From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/8 v2] ARM OMAP2+ GPMC: add bus children
Date: Wed, 25 Feb 2015 18:26:06 +0200
Message-ID: <54EDF79E.4010104@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDB9F0.9030701@ti.com> <54EDE4F1.10000@cit-ec.uni-bielefeld.de> <54EDF5DE.9010607@ti.com> <54EDF6E5.9070405@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EDF6E5.9070405@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rabel@cit-ec.uni-bielefeld.de, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 25/02/15 18:23, Robert Abel wrote:
> Hi Roger,
> 
> On 25 Feb 2015 17:18, Roger Quadros wrote:
>> OK. Would be interesting to see how unconditional call to of_platform_decide_create() behaves
>> for your case.
> I'm not able to test today, so results will be in tomorrow. If that doesn't work, I'll just resubmit my first patch with the conditional.

Tomorrow is fine.

> 
> I'll be posting a v3 of this entire patch series tomorrow after testing. I think I should leave your ACKs out for you to re-ACK?

If you are not changing the patches I've acked you can keep my ACK.

cheers,
-roger
