From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
Date: Mon, 11 Feb 2013 12:52:17 -0600
Message-ID: <51193DE1.6080704@ti.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com> <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com> <20130210025225.GB4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130210025225.GB4801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 02/09/2013 08:52 PM, Tony Lindgren wrote:
> Hi,
> 
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [130208 11:41]:
>> The OMAP4 Blaze Tablet is TI OMAP4 processor-based
>> development platform in a tablet formfactor.
>> The platform contains many of the features found in
>> present-day handsets (such as audio, video, wireless
>> functions and user interfaces) and in addition
>> contains features for software development and test.
>>
>> This patch adds initial support for the OMAP4 Blaze
>> Tablet development platform. Additional functionality
>> depends on different drivers and code modifications that
>> are not upstreamed yet so will be added later.
> 
> Nice that you have it working, however, we're not adding
> any more board-*.c files as we're moving things to device
> tree based booting.
> 
> Care to try to get the basic .dts file done for this?
> You will probably need to add CONFIG_ARM_APPENDED_DTB=y
> and CONFIG_ARM_ATAG_DTB_COMPAT=y to omap2plus_defconfig
> and append the .dtb file to zImage and run mkimage then
> manually to boot it. But you should get serial and MMC
> at least working to start with :)

Please note that the blaze is derived from the omap4-sdp board and so I
would hope that we can use the existing for sdp dts and board file for
blaze. In fact this is what I do today for basic booting.

So unless there is some feature on the blaze that is not compatible with
the original sdp, we should just use the sdp dts.

Cheers
Jon
