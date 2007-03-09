From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: Running u-boot directly from RAM
Date: Fri, 9 Mar 2007 15:10:43 +0530
Message-ID: <2d51cbf80703090140y605cf31av88b5df96a66c236b@mail.gmail.com>
References: <61445c750703090118y3c81b898y552a330c32df9152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <61445c750703090118y3c81b898y552a330c32df9152@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/9/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hello
>
> I am working on a omap850 based custom board. As per my understanding,
> one of the earlist things u-boot does is initializing the SDRAM
> controller so that RAM can be used for setting up execution
> environment i.e. setting up stack etc. then u-boot relocates itself to
> RAM and so on.
>
> If I have to run u-boot directly from RAM without flashing it i.e. I
> copy u-boot to RAM directly using one of the utilities and make it run
> from there, I am doing something wrong here? In this case when the
> u-boot is copied directly to RAM, has the RAM been initialized? The
> u-boot image gets successfully downloaded to RAM but is the RAM
> initialized in order to executre u-boot directly. Very naive question
> indeed.
>
> -pharaoh.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

Check this:

In cpu/xxx/start.S file


CONFIG_SKIP_LOWLEVEL_INIT
CONFIG_SKIP_RELOCATE_UBOOT

                [ARM only] If these variables are defined, then
                certain low level initializations (like setting up
                the memory controller) are omitted and/or U-Boot does
                not relocate itself into RAM.
                Normally these variables MUST NOT be defined. The
                only exception is when U-Boot is loaded (to RAM) by
                some other boot loader or by a debugger which
                performs these intializations itself.

Have you defined these?

Do you are already have another boot-loader on your board? If no then
the utility which you are using for downloading the image to RAM must
initialize the RAM (I think!!)
-- 

Regards,
Sandeep.
