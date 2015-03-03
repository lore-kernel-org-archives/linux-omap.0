From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/8] ARM OMAP2+ GPMC: add bus children
Date: Tue, 3 Mar 2015 12:09:59 +0200
Message-ID: <54F58877.2090608@ti.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424961956-29353-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<54F045F2.7010005@ti.com> <CAMdRc4F2EaDxrBAMUQ3NGvBt4sMnYX3FQXZttFzcPZJdKkOMLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMdRc4F2EaDxrBAMUQ3NGvBt4sMnYX3FQXZttFzcPZJdKkOMLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Robert,

On 27/02/15 17:08, Robert Abel wrote:
> Hi Roger,
> 
> On Fri, Feb 27, 2015 at 11:24 AM, Roger Quadros <rogerq@ti.com> wrote:
>>> +     /* is child a common bus? */
>>> +     if (of_match_node(of_default_bus_match_table, child))
>>> +             /* create children and other common bus children */
>>> +             if (of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev))
>>> +                     goto err_child_fail;
>>
>> this would print "failed to create gpmc child" but we have already created
>> the gpmc child in the first of_platform_device_create() call.
>> A more appropriate message would be "failed to populate all children of child->name"
>>
>> Also do you want to return failure?
>> it will result in of_node_put() of the child and another print message
>> about "probing gpmc child %s failed" in gpmc_probe_dt().
>>
>> IMO if the GPMC node's child was created fine then we shouldn't return error.
> 
> As of_platform_populate _always_ return 0 no matter what, the only way
> to reach that message is if probing the child failed.

GPMCs child is already probed. It is the child's child we are talking about
in of_platform_populate.

> As I cannot see into the future when of_platform_populate might
> actually be changed to return meaningful codes, we shouldn't try to
> foresee what the actual problem might be today either. This is a
> battle for another day.
> 

If that is the case then I'd rather not check for return value of of_platform_populate().
Failure in populating GPMC child's children is already out of scope of GPMC driver.

cheers,
-roger
