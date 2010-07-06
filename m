From: "Hemanth V" <hemanthv-l0cyMroinI0@public.gmane.org>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Tue, 6 Jul 2010 14:47:25 +0530 (IST)
Message-ID: <26287.10.24.255.17.1278407845.squirrel@dbdmail.itg.ti.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com>
	<fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
	<20100218170946.GO21755@atomide.com>
	<fa686aa41002180929u555e2af0s9f0646fccb744955@mail.gmail.com>
	<AANLkTinEfJqvRZKqMaXY3_EE4WJT3W3_j0Kwg89pt_SU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTinEfJqvRZKqMaXY3_EE4WJT3W3_j0Kwg89pt_SU-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, govindraj.raja-l0cyMroinI0@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> On Thu, Feb 18, 2010 at 11:29 AM, Grant Likely
> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Thu, Feb 18, 2010 at 10:09 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>> * Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> [100218 08:26]:
>>>> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> > * Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org> [100203 02:19]:
>>>> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2=
001
>>>> >> From: Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>
>>>> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>>>> >> Subject: [PATCH] Update platform files
>>>> >>
>>>> >> This patch updates platform files for
>>>> >> fifo, slave support
>>>> >>
>>>> >> Signed-off-by: Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>
>>>> >
>>>> > This should get merged via the spi-devel list with the other patches.
>>>> >
>>>> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> Tony, do you want me to add your acked-by to patches 2 & 3?
>>>
>>> No thanks, I've only looked at them briefly.
>>
>> Okay, thanks.
>>
>> Hemanth, I'm going to drop this series for the moment. =A0I'd like to
>> see some feedback/acks from current users and maintainers of the
>> omap2_mcspi driver before I merge support, especially now when the
>> merge window is about to open and it hasn't gotten any linux-next
>> exposure.
>>
>>>> Also, what is your feeling about patch 3/3, spi slave support. =A0spi
>>>> slave usage model is still a matter under debate, but that patch
>>>> doesn't touch core spi code, so I'm okay to merge it as a
>>>> driver-specific feature. =A0However, I'm not convinced that it is
>>>> actually a useful patch to merge yet, so I'll defer to you on this
>>>> one. =A0Thoughts?
>>>
>>> Up to you to decide. But here's my experience so far..
>>>
>>> Based on my experience if temporary hacks are merged, then nobody
>>> bothers to clean them up properly afterwards and the clean-up task
>>> unfairly falls on the maintainer.
>>>
>>> So IMHO, hacks like that are better floating on the mailing list
>>> until they're properly done. It's best to concentrate on getting
>>> the core things done right to make long term support easier.
>>
>> Right, I agree. =A0I'll ignore patch 3 entirely until I at least see a
>> patch for an in-tree user.
>
> Hi Hemanth.  Could you please respin patches 1 and 2 against
> 2.6.35-rc3?  The current patches do not apply anymore.
>

Grant,

Govindraj marked in this mail would rebase the patches and post the
same.

Thanks
Hemanth



---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
