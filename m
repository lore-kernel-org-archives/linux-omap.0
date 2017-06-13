From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP4: crypto support
Date: Tue, 13 Jun 2017 17:42:05 +0300
Message-ID: <027b40b6-1961-275b-7b7e-00a51e86e8f3@ti.com>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
 <ab778bfd-9397-4cb0-0741-557da57bba83@ti.com>
 <20170613142458.32g3iqcijc4ij4b7@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170613142458.32g3iqcijc4ij4b7@earth>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 13/06/17 17:24, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jun 13, 2017 at 04:49:18PM +0300, Tero Kristo wrote:
>> On 13/06/17 12:28, Sebastian Reichel wrote:
>>> This adds crypto support for OMAP4, which was missing for some reason.
>>> This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
>>> DES are working according to selftest.
>>>
>>> Changes since PATCHv1:
>>>    * remove patch adding des_fck to DT
>>>    * add patch removing aes[12]_fck from DT
>>>    * add patch renaming hwmod aes to aes1 in DT
>>>    * update hwmod patches according to feedback from Tero
>>>    * add patch for aes2 hwmod
>>>
>>> -- Sebastian
>>
>> I just posted a few extra patches on top of this series, for adding
>> the missing dts data for aes2 and adding sham accelerator also.
> 
> Thanks :)
> 
>> The dts data should be applied first if you want to avoid any
>> issues with hwmod core complaining about missing DT data, so the
>> sequencing of this series and mine need to be done carefully.
> 
> There is also a warning printed if DT references a missing hwmod
> entry (that's how I noticed this in the first place). It's less
> noisy, though. Since kernel builds and boots with any order and
> crypto hardware does not work at the moment there is no real
> problem with bisect. I suggest to merge the DTS patches normally
> through the separate dt branch.

Yeah thats actually true also. Up to Tony to decide how he wants to 
handle these. The huge warning is mainly an annoyance.

-Tero
