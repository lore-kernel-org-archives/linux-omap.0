From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 07:57:58 -0600
Message-ID: <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	<AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	<20101119125353.GB5818@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60634 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab0KSN57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 08:57:59 -0500
Received: by mail-qy0-f175.google.com with SMTP id 2so59700qyk.20
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 05:57:59 -0800 (PST)
In-Reply-To: <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Felipe,

On Fri, Nov 19, 2010 at 6:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi Hari,
>
> On Fri, Nov 19, 2010 at 06:29:39AM -0600, Kanigeri, Hari wrote:
>>
>> How do you know that a response is received for a particular sender ?
>
> think of it as FIFO. So the first completed message is the first in your
> list of requests. Ain't that easy ? :-)

Actually it isn't that easy ;) because there is no guarantee that the
completed message is the first one in the list of requests.
Responses could be asynchronous and we cannot depend on serialized
handling of requests on BIOS...even in some cases you might not even
get a response for particular request in which case you have to handle
that in IPC module.

eg: Process A sends a message to M3 core to kick off some translation
in some codec, the thread handling this request running on BIOS would
kick off the translation and wait for the completion before sending
the response. In the mean time BIOS will be handling other requests
coming to it, and shouldn't be blocked until the completion of first
request.


>
> Still it doesn't the fact that currently you allow for that. There are
> malware writers everywhere. But hey, it would be cool to have mailbox
> appear on securityfocus.com :-p
>

Agree about malware writers. Add PM interfaces as well to the list as
one can misuse them as well ;)


Thank you,
Best regards,
Hari Kanigeri
