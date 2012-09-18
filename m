From: Fernando Lugo <lugo.fernando@gmail.com>
Subject: Re: [PATCHv2 0/3] remoteproc: introduce rproc recovery
Date: Tue, 18 Sep 2012 13:25:35 -0500
Message-ID: <CAA=eUFmnB-UT5-m8tLPponifQgkhi4g6L5yVoi938=oa8tMqZA@mail.gmail.com>
References: <1346351174-28441-1-git-send-email-fernando.lugo@ti.com>
	<CAK=WgbaoPMj9OobHuC=VObTjvT--faen2_rfY-s4Jk-+Fqi5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbaoPMj9OobHuC=VObTjvT--faen2_rfY-s4Jk-+Fqi5iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On Tue, Sep 18, 2012 at 4:59 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Fernando,
>
> On Thu, Aug 30, 2012 at 9:26 PM, Fernando Guzman Lugo
> <fernando.lugo@ti.com> wrote:
>> These set of patches make possible the remoteproc recover after a crash.
>> This is a hard recovery, that means the remoteproc is reset and it will
>> start from the beginning. When a crash happen all the virtio devices are
>> destroyed. Therefore, both rpmsg drivers and devices are gracefully
>> removed which also cause rproc users become 0 and the remoteproc is turned
>> off. After the virtio devices are destroyed the crash handler function
>> will read the virtio information from the firmware in order to recreate
>> the virtio devices that will boot the remoteproc and everything will be
>> functional again.
>
> Applied to remoteproc's for-next branch with a few changes (so we
> don't miss the merge window).
>
> The changes are detailed in the commit logs of the patches, please let
> me know if there's any issue.

That sounds good. Thanks.

Regards,
Fernando.

>
> Thanks!
> Ohad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
