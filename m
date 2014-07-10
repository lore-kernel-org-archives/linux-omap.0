From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Anybody working on tidspbridge?
Date: Thu, 10 Jul 2014 08:54:18 +0300
Message-ID: <53BE2A8A.5080001@gmail.com>
References: <53A4569B.70604@gmail.com> <53A45BBD.4040201@gmail.com>
 <20140629164250.GA31625@kroah.com> <53BBE895.4020105@gmail.com>
 <alpine.DEB.2.01.1407081452580.5181@pmeerw.net>
 <20140708143659.GB3104@kroah.com> <53BC3A94.4050208@ti.com>
 <20140709070726.GF28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140709070726.GF28884@atomide.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Greg KH <gregkh@linuxfoundation.org>, Peter Meerwald <pmeerw@pmeerw.net>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On  9.07.2014 10:07, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [140708 11:40]:
>> Hi Peter,
>>
>> On 07/08/2014 09:36 AM, Greg KH wrote:
>>> On Tue, Jul 08, 2014 at 03:03:58PM +0200, Peter Meerwald wrote:
>>>> Hello,
>>>>
>>>>>> Given the total lack of response here, I suggest just deleting the
>>>>>> driver.  No one has ever done the "real work" that is going to be
>>>>>> required to get this code out of staging.  It has had build errors
>>>>>> causing it to not even be usable for some kernel versions with no one
>>>>>> noticing, so I doubt anyone cares about it anymore here.
>>>>>
>>>>> Cc'ing some more people who might be interested. If no one offers to
>>>>> work on the driver in the next couple of days, I'll send a patch to
>>>>> remove it.
>>>>
>>>> I'm using the driver (with kernel 3.7) and it works reasonably well for
>>>> me; removing it seems a bit harsh.
>>>
>>> Using it is different from being able to maintain the code and move it
>>> out of the staging tree.  Also, 3.7 is really old and obsolete, not much
>>> we can do with that kernel version :)
>>>
>>> Are you able to work on the code and do the effort needed to get it out
>>> of the staging tree?  If so, great, if not, we are going to have to
>>> delete it, sorry.
>>
>> I agree with Greg here. In fact, the current TODO does not do enough
>> justice to the amount of work required to make it even work on the
>> latest kernel. Most of the TIers who worked on this driver have moved on
>> as Kristina would have figured with her bounced emails. So I do suggest
>> that this driver be deleted from the kernel tree. If there are enough
>> number of folks using it (not sure how many are out there), it can be
>> worked on out-of-tree and brought back in a cleaner fashion rather than
>> keeping a broken stale driver in the kernel.
>
> I agree, not much has improved with this driver since it got added into
> staging except just compile fixes.
>
> Regards,
>
> Tony

Well, recently I've sent a couple of patches which implement stuff from 
TODO [1]. However, with the migration to DT, my focus now is to have a 
kernel/userspace that boots at all and this leaves no free cycles for 
DSP. Maybe tidspbridge can be left in staging until DT migration is 
finished, that way me (and maybe other people) will have the time needed 
to try to implement what remains in TODO. Also, keep in mind there will 
(hopefully) be another omap3 end-user device released by the end of the 
year (Neo900), which most probably will gain more developers interested 
in fixing the DSP driver.

Regards,
Ivo

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/tidspbridge?id=559c71fe5dc3bf2ecc55afb336145db7f0abf810
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/tidspbridge?id=a3b22220a48bd14c9ba4ca8d051b0c92d5bc3866
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/tidspbridge?id=d30555853052bbec8497260ba888b7d696bed9b8
