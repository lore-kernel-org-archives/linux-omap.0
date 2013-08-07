From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH] usb: dwc3-pci: Ensure system sleep PM ops are defined
 only when used
Date: Wed, 7 Aug 2013 18:01:00 +0800
Message-ID: <CAAfg0W5fWdvX7aU8y29op70SFod=xqrr9kpxUUi=NKy71Y89Wg@mail.gmail.com>
References: <1375804166-3205-1-git-send-email-broonie@kernel.org>
	<CAOMZO5A_M3u4A3j7pFcooZ6jVi5LikERM4CVjL4bB2z5YVeTXQ@mail.gmail.com>
	<20130807093407.GT6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56214 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258Ab3HGKBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 06:01:01 -0400
Received: by mail-qc0-f172.google.com with SMTP id a1so790890qcx.3
        for <linux-omap@vger.kernel.org>; Wed, 07 Aug 2013 03:01:00 -0700 (PDT)
In-Reply-To: <20130807093407.GT6427@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linaro-kernel <linaro-kernel@lists.linaro.org>, linux-omap@vger.kernel.org

On 7 August 2013 17:34, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 06, 2013 at 10:35:52PM -0300, Fabio Estevam wrote:
>> On Tue, Aug 6, 2013 at 12:49 PM, Mark Brown <broonie@kernel.org> wrote:
>> > From: Andy Green <andy.green@linaro.org>
>> >
>> > You might have CONFIG_PM, but you might not have CONFIG_SUSPEND, in which
>> > case these are unused.
>> >
>> > Signed-off-by: Andy Green <andy.green@linaro.org>
>> > Signed-off-by: Mark Brown <broonie@linaro.org>
>
>> What about doing this instead?
>
> Makes sense to me - Andy?

Sure, it seems a much more complete solution.

-Andy
