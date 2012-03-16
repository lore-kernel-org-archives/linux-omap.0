From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH v4] misc: ddr: add LPDDR2 data from JESD209-2
Date: Sat, 17 Mar 2012 03:20:36 +0530
Message-ID: <4F63B5AC.5080808@ti.com>
References: <1331929177-11694-1-git-send-email-aneesh@ti.com> <1331931007-584-1-git-send-email-aneesh@ti.com> <20120316214334.GA24925@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120316214334.GA24925@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday 17 March 2012 03:13 AM, Greg KH wrote:
> On Sat, Mar 17, 2012 at 02:20:07AM +0530, Aneesh V wrote:
>> add LPDDR2 data from the JEDEC spec JESD209-2. The data
>> includes:
>>
>> 1. Addressing information for LPDDR2 memories of different
>>     densities and types(S2/S4)
>> 2. AC timing data.
>>
>> This data will useful for memory controller device drivers.
>> Right now this is used by the TI EMIF SDRAM controller
>> driver.
>>
>> Cc: Greg KH<greg@kroah.com>
>> Signed-off-by: Aneesh V<aneesh@ti.com>
>
> What happened to the other patches that depended on this one?

I was not sure what was the convention regarding re-submitting just one
patch in a series. I realize that you prefer having the whole series
again. I will send it shortly.

thanks,
Aneesh
