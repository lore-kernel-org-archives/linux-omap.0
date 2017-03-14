From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: provide space for more hwmod
 flags
Date: Tue, 14 Mar 2017 12:49:32 +0200
Message-ID: <b3c0f302-2ed8-403a-cc06-ba0c555c3b1d@ti.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
 <1489405996-10718-2-git-send-email-rogerq@ti.com>
 <3612df6e-940e-9541-558c-be1f742c469f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3612df6e-940e-9541-558c-be1f742c469f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/03/17 15:35, Sekhar Nori wrote:
> On Monday 13 March 2017 05:23 PM, Roger Quadros wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> 'flags' member of omap_hwmod structure is fast running
>> out of space with 16 different flags already defined.
>>
>> Make flags a 32-bit entity so as to allow for more flags.
>>
>> This results is a ~2.3K data section size increase with
>> TI config fragments.
> 
> This line needs to be changed to refer to omap2plus_defconfig.

OK.

> 
>>
>> before:
>>    text	   data	    bss	    dec	    hex	filename
>> 8886648	 610452	 261876	9758976	 94e900	vmlinux
>>
>> after:
>>    text	   data	    bss	    dec	    hex	filename
>> 8886584	 612820	 261876	9761280	 94f200	vmlinux
> 
> I guess this data is probably stale as well. Here is the before and
> after numbers using omap2plus_defconfig on v4.11-rc2
> 
> before:
>    text	   data	    bss	    dec	    hex	filename
> 8186930	3082444	8252992	19522366	129e33e	vmlinux
> 
> after:
>    text	   data	    bss	    dec	    hex	filename
> 8186922	3084812	8252992	19524726	129ec76	vmlinux
> 
> The size increase remains at ~2.3K in data section.
> 

Thanks for the new figures. I'll resend the patch with updated data.

-- 
cheers,
-roger
