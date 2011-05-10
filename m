From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [URGENT - PATCH FOR 2.6.39] omap: iommu: Return IRQ_HANDLED in
 fault handler when no fault occured
Date: Tue, 10 May 2011 16:32:40 +0300 (EEST)
Message-ID: <20110510.163240.175424489831028844.Hiroshi.DOYU@nokia.com>
References: <1303912982-10309-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201104291203.11174.laurent.pinchart@ideasonboard.com>
	<201105101439.56757.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201105101439.56757.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, dacohen@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: ext Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [URGENT - PATCH FOR 2.6.39] omap: iommu: Return IRQ_HANDLED in fault handler when no fault occured
Date: Tue, 10 May 2011 14:39:56 +0200

> Hi Tony,
> 
> On Friday 29 April 2011 12:03:10 Laurent Pinchart wrote:
>> Hi Tony,
>> 
>> On Wednesday 27 April 2011 16:03:02 Laurent Pinchart wrote:
>> > The iommu shares an interrupt line with the OMAP3 ISP. The iommu
>> > interrupt handler must check the fault status and return IRQ_HANDLED
>> > when no fault occured.
>> > 
>> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> 
>> Could you please pick this one up for 2.6.39 ? As far as I know David is on
>> holidays so he might not be able to review the patch before the 2.6.39
>> release.
> 
> Ping. Please.

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
