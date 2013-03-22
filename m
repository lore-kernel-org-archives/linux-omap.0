From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] mach_omap2: use PTR_RET instead of IS_ERR + PTR_ERR
Date: Fri, 22 Mar 2013 13:39:00 -0500
Message-ID: <514CA544.5080006@ti.com>
References: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com> <20130312110557.GF30923@n2100.arm.linux.org.uk> <5149FFDF.6050501@ti.com> <20130322163650.GN30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130322163650.GN30923@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 03/22/2013 11:36 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 20, 2013 at 01:28:47PM -0500, Jon Hunter wrote:
>> Sorry I am now not sure I follow you here. Someone just pointed out to
>> me that PTR_RET() is defined as ...
>>
>> static inline int __must_check PTR_RET(const void *ptr)
>> {
>> 	if (IS_ERR(ptr))
>> 		return PTR_ERR(ptr);
>> 	else
>> 		return 0;
>> }
>>
>> So the above change appears to be equivalent. Is there something that is
>> wrong with the current implementation that needs to be fixed?
> 
> No - I misread it as PTR_ERR not PTR_RET.  Your patch is fine.

Thanks for confirming. I had made the same mistake recently too!

Jon
