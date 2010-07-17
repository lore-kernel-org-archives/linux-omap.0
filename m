From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 00/15] ti dspbridge: Remove CamelCase, reagroup variables
Date: Fri, 16 Jul 2010 19:17:12 -0500
Message-ID: <4C40F688.80507@ti.com>
References: <1278728649-21012-1-git-send-email-rene.sapiens@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40053 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759483Ab0GQARX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jul 2010 20:17:23 -0400
In-Reply-To: <1278728649-21012-1-git-send-email-rene.sapiens@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "greg@kroah.com" <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "ohad@wizery.com" <ohad@wizery.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 7/9/2010 9:23 PM, Sapiens, Rene wrote:
> The intention of this serie of patches is to rename the remaining variables
> with camel case. Words will be renamed avoiding CamelCase and Hungarian
> notation. Also the variables in the prototypes  will be renamed to make them
> match with the ones in the function definitions.
>
[...]
>   74 files changed, 2471 insertions(+), 2439 deletions(-)
>
>

Some of your patches produce:

warning: drivers/staging/tidspbridge/include/dspbridge/dspdefs.h has 
type 100644, expected 100755

None of the files had their permissions changed so I guess they should 
be fine to merge, unless anybody else complains... so ACK.

For future patches please check you are not changing file mode or use:

git config core.filemode false

Regards,

Omar
