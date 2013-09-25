From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 09:09:09 +0200
Message-ID: <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com>
	<52427ECA.1080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59228 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab3IYHJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 03:09:10 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so6199302obb.40
        for <linux-omap@vger.kernel.org>; Wed, 25 Sep 2013 00:09:10 -0700 (PDT)
In-Reply-To: <52427ECA.1080500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

CC - Nikolaus Schaller

On Wed, Sep 25, 2013 at 8:12 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 24/09/13 23:04, Belisko Marek wrote:
>> Hi,
>>
>> we're using connector-analog-tv driver to enable TV out on gta04
>> board. There is exception that we need to change some twl registers +
>> some gpio when enable/disable TV output. My question is if there is
>> some way how to do that or do we need to copy'n'paste code from
>> connector-analog-tv driver and extend it for handling we need (let's
>> call it hack)?
>
> What are those TWL registers and GPIO used for? If they are board
> specific things, then I see two options:
>
> - Presuming you're using board files, you could add
> platform_enable/disable callbacks to the connector's platform_data, and
> make the connector driver call those callbacks.
>
> - Create a new display encoder driver, which handles the TWL and GPIO,
> and position it in the video pipeline between VENC and the connector.
>
> The first option is obviously not upstreamable, as it won't work with
> DT. And I'm not enthusiastic about merging board specific display
> drivers either, but so far I haven't figured better ways to implement
> board specific oddities.
>
>  Tomi
>
>

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
