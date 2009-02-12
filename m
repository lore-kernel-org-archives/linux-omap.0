From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH PM] OMAP3 McSPI:  Adds context save/restore
Date: Wed, 11 Feb 2009 16:34:57 -0800
Message-ID: <20090212003455.GF13748@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F54B9C80@dbde02.ent.ti.com> <498C29E2.5020303@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62075 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZBLAfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 19:35:01 -0500
Content-Disposition: inline
In-Reply-To: <498C29E2.5020303@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "ext Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, "V, Hemanth" <hemanthv@ti.com>

* Aaro Koskinen <aaro.koskinen@nokia.com> [090206 04:17]:
> Hello,
>
> ext Nayak, Rajendra wrote:
>> From: Hemanth V <hemanthv@ti.com>
>>
>> This patch adds context save/restore feature to McSPI driver.
>> This includes fixes by Aaro Koskinen
>>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>
> For some reason git-am does not take this to my tree, but when applied  
> with patch it's OK. So the patch may need to be refreshed, but for the  
> code itself:
>
> Reviewed-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>

I've noted that happens when the mail is quoted-printable. One way to
deal with that is to pipe the mail to mewdecode -q > /tmp/out.patch,
then manually edit the patch to remove the quoted printable header line.

Anybody know of a better way to deal with these patches?

Tony
