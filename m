From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 2/8] remoteproc: add omap implementation
Date: Wed, 29 Jun 2011 09:31:19 -0600
Message-ID: <BANLkTikGaYjjuXOb0ANM4+-j3nWFJ1BaCg@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-3-git-send-email-ohad@wizery.com> <20110627210007.GC20865@ponder.secretlab.ca>
 <BANLkTi=4Pp1UYWFsBywRvLL1n=ggCZgAeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53911 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1F2Pbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 11:31:40 -0400
In-Reply-To: <BANLkTi=4Pp1UYWFsBywRvLL1n=ggCZgAeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

On Wed, Jun 29, 2011 at 9:04 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Tue, Jun 28, 2011 at 12:00 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> Very little for me to comment on here. =A0However, something I just
>> noticed. =A0Why is it necessary to pass in THIS_MODULE to the
>> rproc_register function? =A0Having a reference to the pdev gives you=
 the
>> pointer to the driver, which has the THIS_MODULE value in it. =A0Tha=
t
>> should be sufficient.
>
> Nice one, thanks !
>
>> /me also isn't sure if incrementing the refcount on the module is th=
e
>> best way to prevent the rproc from going away, but I haven't dug int=
o
>> the details in the driver code to find out. =A0Drivers can get unbou=
nd
>> from devices without the driver being unloaded, so I imagine there i=
s
>> an in-use count on the device itself that would prevent driver
>> unbinding.
>
> Yes, increasing the module refcount is necessary to prevent the user
> from removing the driver when the rproc is used.

That prevents removing the module which necessitates unbinding the
device.  However, I believe it is possible to unbind a driver
/without/ the module being unloaded.  My question (for which I don't
have an answer) is whether or not there is a way to increment a
refcount on users of the driver bound to the device..

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
