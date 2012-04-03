From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 0/3] spi: omap2-mcspi: driver updates
Date: Tue, 3 Apr 2012 11:25:26 +0530
Message-ID: <CAM=Q2cse5_mZtfNchE+uYpNPLd+_TSTFswxhfk0feaoMqmT7eA@mail.gmail.com>
References: <1333193818-3984-1-git-send-email-shubhrajyoti@ti.com>
	<20120402194049.06B613E314E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120402194049.06B613E314E@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant

On Tue, Apr 3, 2012 at 1:10 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wr=
ote:
> On Sat, 31 Mar 2012 17:06:55 +0530, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> =
wrote:
>> The patch series does the following cleanups
>> - Makes the driver use autosuspend
>> - Folds Benoit's bus_num removal patch in the series
>> - The tmp variable is used to write this can be optimised
>> =A0as it is not needed if the value is directly written.
>> =A0Acknowledge =A0Tarun for the suggestion.
>>
>> This is also available through
>> git =A0 =A0 : git://gitorious.org/linus-tree/linus-tree.git
>> branch =A0: spi_next
>>
>> Rebased to Grant's spi/next branch.
>
> Merged, thanks.
Thanks ,

>
> BTW, it's easier to pull if you put the branch after the git URL (I
> can cut and paste all at once):
>
> =A0 =A0 =A0 =A0git://gitorious.org/linus-tree/linus-tree.git spi_next
>
> "git request-pull" can be your friend here.
>
OK good idea will do that.

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
