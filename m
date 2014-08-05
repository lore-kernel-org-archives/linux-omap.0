From: pekon@pek-sem.com
Subject: Re: [PATCH 1/3] mtd: nand: omap: Revert to using software ECC by
 default
Date: Wed, 06 Aug 2014 02:00:54 +0530
Message-ID: <099046e951bd70b9bfb638d2ac9d539a@pek-sem.com>
References: <1407233482-11642-1-git-send-email-rogerq@ti.com>
 <1407233482-11642-2-git-send-email-rogerq@ti.com>
 <CANOLnOM-Q4b8N5T522Vc_gXTSj2C-mxV6GV0hRTDPscpPgXO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CANOLnOM-Q4b8N5T522Vc_gXTSj2C-mxV6GV0hRTDPscpPgXO6A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Grazvydas Ignotas <notasas@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, artem.bityutskiy@linux.intel.com, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tuesday 05 August 2014 09:45 PM, Grazvydas Ignotas wrote:
> On Tue, Aug 5, 2014 at 1:11 PM, Roger Quadros <rogerq@ti.com> wrote:
>> For v3.12 and prior, 1-bit Hamming code ECC via software was the
>> default choice. Commit c66d039197e4 in v3.13 changed the behavior
>> to use 1-bit Hamming code via Hardware using a different ECC layout
>> i.e. (ROM code layout) than what is used by software ECC.
>>
As per OMAP3 TRM [1], the NAND ECC layout required for
NAND boot is same as that of OMAP_ECC_HAM1_CODE_HW. So
above mentioned 'commit c66d039197e4' does not break
backward compatibility as far as NAND boot is concerned.

AFAIK, all users on OMAP3 used HAM1_HW which is same
as HAM1 today. So unless we have a real OMAP3 user who
(1) had created file-system using HAM1_SW &&
(2) now wants to migrate to new kernel, I don't think
its wise to re-introduce HAM1_SW4 ECC schemes.

Instead we are trying to push OMAP3 users to migrate to
BCH4_SW (supported by ROM) or BCH8_SW ECC schemes.

Please understand
commit c66d039197e42af8867e5d0d9b904daf0fb9e6bc
was part of larger series to clean-up NAND driver and
remove obsolete or redundant code. So this was
intentional change.



>> This ECC layout change causes NAND filesystems created in v3.12
>> and prior to be unusable in v3.13 and later. So revert back to
>> using software ECC by default if an ECC scheme is not explicitely
>> specified.
>>
>> This defect can be observed on the following boards during legacy 
>> boot
>>
>> -omap3beagle
>> -omap3touchbook
>> -overo
>> -am3517crane
>> -devkit8000
>> -ldp
>> -3430sdp
>
> omap3pandora is also using sw ecc, with ubifs. Some time ago I tried
> booting mainline (I think it was 3.14) with rootfs on NAND, and while
> it did boot and reached a shell, there were lots of ubifs errors, fs
> got corrupted and I lost all my data. I used to be able to boot
> mainline this way fine sometime ~3.8 release. It's interesting that
> 3.14 was able to read the data, even with wrong ecc setup.
>
> Do you think it's safe again to boot ubifs created on 3.2 after
> applying this series?
>
Are you sure you are using "sw" ECC scheme ?
Can you please share the ecc-layout of the NAND page, because
as per [1] you should not be able to Boot from NAND then.

IIRC..
- ECC layout of HAM1_SW has ECC bytes towards end of OOB-section.
- ECC layout of HAM1_HW has ECC bytes towards staring of OOB section.


with regards, pekon


[1] http://www.ti.com/product/omap3530
http://www.ti.com/lit/pdf/spruf98  (Revision Y)
Chapter 25: Initialization
Section: 25.4.7 Memory Booting
	Sub-Section: NAND
	Figure 25-19. ECC Locations in NAND Spare Areas


------------------------
Powered by BigRock.com


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
