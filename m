From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] spi: omap2-mcspi: driver updates
Date: Wed, 28 Mar 2012 11:18:35 +0530
Message-ID: <CAM=Q2css7YLqgo4fsLPoPLi2rPkpS56-RXchM1dXWOe0Td2ieQ@mail.gmail.com>
References: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
	<20120327215838.AB7C33E13A0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120327215838.AB7C33E13A0@localhost>
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

Hi Grant,

On Wed, Mar 28, 2012 at 3:28 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Mon, 26 Mar 2012 19:14:35 +0530, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> =
wrote:
>> The patch series does the following cleanups
>> - Converts the spi to module_platform_driver
>> - Use the devm functions so that the freeing need not
>> =A0 be done in the driver.
>> - Makes the driver use autosuspend
>> - Folds Benoit's bus_num removal patch in the series
>>
>> Changes from the previous version
>> - Makes the driver use autosuspend
>> - Folds Benoit's bus_num removal patch in the series
>>
>>
>> This is also available through
>> git =A0 =A0 : git://gitorious.org/linus-tree/linus-tree.git
>> branch =A0: spi
>
> Hi Shubhrajyoti,
>
> I'll queue these ones up for v3.5 unless you make the argument that
> they are bug fixes that must go into v3.4.

No  thats fine if targeted for v3.5 .
Thanks,

>
> g.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
