From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: fix bridge_open memory leaks
Date: Tue, 31 Jan 2012 12:09:17 -0600
Message-ID: <CAJ6Av5NRnSax1aXT6fLg5GVRy+c+Xb9CXOXNn-2H4zprHKTi_A@mail.gmail.com>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
	<1327972818-30993-2-git-send-email-omar.ramirez@ti.com>
	<20120131081751.GB3294@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44482 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab2AaSJS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 13:09:18 -0500
Received: by obcva7 with SMTP id va7so237002obc.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 10:09:17 -0800 (PST)
In-Reply-To: <20120131081751.GB3294@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 2:17 AM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> On Mon, Jan 30, 2012 at 07:20:17PM -0600, Omar Ramirez Luna wrote:
>> There are two members of pr_ctxt allocated during bridge_open that
>> are never freed resulting in memory leaks, these are stream_id and
>> node_id, they are now freed on release of the handle (bridge_release=
)
>> right before freeing pr_ctxt.
>>
>> Error path for bridge_open was also fixed since the same variables
>> could result in memory leaking due to missing handling of failure
>> scenarios. While at it, the indentation changes were introduced to
>> avoid interleaved goto statements inside big if blocks.
>>
>
> You mentioned in the cover letter email that you wanted these to go
> into stable. =A0I don't think that is needed here. =A0These are tiny
> leaks that we aren't going to hit in real life.

They are hit each time an app opens a handle e.g.:

gst-launch <something>

So after 'X' number of playbacks there won't be memory left.

> But if we did want to include them in stable then we would add a tag
> to the patch next to the Signed-off-by.

I thought first wait for inclusion and then send it to stable list,
given that there are other patches touching this file and I don't know
the order they are going to be picked, it is likely that I have to
rebase it given that I might be the last in the queue.

> Read Documentation/stable_kernel_rules.txt. =A0It's short.

I had read it before.

I don't mind these to sit outside stable tree if they are not required =
though.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
