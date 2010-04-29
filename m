From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 2/2] omap: gpmc-nand: add ability to keep timings defined
 	by the bootloader
Date: Thu, 29 Apr 2010 10:27:33 +0300
Message-ID: <4BD934E5.5080904@compulab.co.il>
References: <cover.1272470212.git.mike@compulab.co.il> <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il> 	<z2hce9ab5791004282127u817d6604oa65b8bf3b9957bda@mail.gmail.com> 	<4BD92CD2.7010907@compulab.co.il> <g2qce9ab5791004290011w84f68a4ak3e24acdc74016265@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:38483 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab0D3VDI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 17:03:08 -0400
In-Reply-To: <g2qce9ab5791004290011w84f68a4ak3e24acdc74016265@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: tony@atomide.com, s-ghorai@ti.com, linux-omap@vger.kernel.org

Vimal Singh wrote:
> On Thu, Apr 29, 2010 at 12:23 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Vimal Singh wrote:
>>> On Wed, Apr 28, 2010 at 9:36 PM, Mike Rapoport <mike@compulab.co.il>
>>> wrote:
>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>> +       if (gpmc_nand_data->keep_timings) {
>>>> +               gpmc_nand_detect_timings();
>>>> +               gpmc_nand_data->gpmc_t = &gpmc_default_timings;
>>>> +       }
>>>> +
>>> I guess moving this part to omap2_nand_gpmc_retime will be a good idea.
>>> As there, once we get old/default timings we can simply skip the
>>> rounding part and directly jump to setting the timings.
>> This way it would be the same as to pass 'gpmc_nand_data->gpmc_t =
>> NULL'. If I correctly understood the previous comments ([1]), the
>> problem with skipping retime is that when L3 clock changes, the gpmc
>> timings became wrong. So, if we convert old/default timings to
>> nanoseconds early during startup every time retime is called it will use
>> the timing settings in nanoseconds thus yielding proper gpmc registers
>> configuration.
> 
> OK. Then I think we can at least put __rounding__ code inside an 'if'
> case, something like:
> if (!gpmc_nand_data->keep_timings) {
> ...
> do rounding for supplied timings from board file.
> ...
> }

Sure, no problem.

>> And, if I'm not terribly mistaken retime should be called each time L3
>> frequency changes, though with current kernel it's not yet the case...
> 
> Yes. This is still left.
> 


-- 
Sincerely yours,
Mike.
