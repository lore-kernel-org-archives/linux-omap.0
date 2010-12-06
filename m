From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 0/3] staging: tidspbridge: bugfixes
Date: Mon, 6 Dec 2010 02:56:56 -0600
Message-ID: <AANLkTikLnW-WJYe0UimmAMPbrOUB+k+wdxrdo8+vcch_@mail.gmail.com>
References: <1288974674-24330-1-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59911 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666Ab0LFI45 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 03:56:57 -0500
Received: by mail-iw0-f176.google.com with SMTP id 36so1121243iwn.21
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 00:56:56 -0800 (PST)
In-Reply-To: <1288974674-24330-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Fri, Nov 5, 2010 at 11:31 AM, Ionut Nicu <ionut.nicu@gmail.com> wrot=
e:
> Changes since v1:
>
> * Split the mgr_enum_node_info patch into two patches:
> one that fixes the issue and one that reorganizes the
> code.
>
> Ionut Nicu (3):
> =A0staging: tidspbridge: fix mgr_enum_node_info
> =A0staging: tidspbridge: mgr_enum_node_info cleanup
> =A0staging: tidspbridge: fix kernel oops in bridge_io_get_proc_load

Pushed to dspbridge.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
