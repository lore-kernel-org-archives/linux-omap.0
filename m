From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 12 May 2012 02:36:32 +0530
Message-ID: <CAJe_Zhc8T-vR8fjFLyT4bz6dj=TUyx0F8k=fAPYn_MnbGW5LBg@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<201205041923.07620.arnd@arndb.de>
	<CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
	<4FA7F009.5010003@wwwdotorg.org>
	<CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
	<4FA94B49.5050500@wwwdotorg.org>
	<CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
	<4FAAC111.9020308@wwwdotorg.org>
	<CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
	<4FABF445.3030105@wwwdotorg.org>
	<CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
	<4FAD6848.40700@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50350 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932903Ab2EKVGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 17:06:34 -0400
Received: by lahd3 with SMTP id d3so2197819lah.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 14:06:32 -0700 (PDT)
In-Reply-To: <4FAD6848.40700@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 12 May 2012 00:58, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/10/2012 01:59 PM, Jassi Brar wrote:
>
>> I think arbitrary numerical tokens are a reasonable price to pay for=
 the
>> robustness and simplicity they bring.
>
> I have to disagree here.
>
> Using phandle+ID is almost as simple, and much more flexible. Global =
IDs
> have a number of disadvantages:
>
> a) You have to somehow keep them unique. Even with just a single .dts
> file, that's going to be a little painful since there's no central ta=
ble
> of these IDs.
>
> What if the DT is composed of a bunch of chunks that represent plugga=
ble
> boards, which may be mixed/matched together depending on what the use=
r
> actually plugged in? Then, you have to be very careful to keep the n
> different files' numbering ranges segregated, or conflicts will occur=
=2E
>
You might want to revisit this point after working out the finer detail=
s of what
you propose for a client's specifier :)

>>
>> Well, I doubt if there would ever be enough such platforms to warran=
t a
>> new generic framework. For now, I would leave that to be a matter be=
tween
>> the dmac driver and its DT node.
>>
>> Similarly let every dmac, being unique, require DT data in it's own =
custom
>> format - I don't believe we can find a generic DT format for every k=
ind of
>> dmac that does exist or would exist. (For ex, you found a way for RM=
K's
>> mux'ed req_lines, but what about assigning priorities to clients whi=
ch is
>> possible with PL08X dmacs but not most others?)
>
> Good question. Again thought that sounds a little like policy, so
> perhaps should be negotiated at runtime rather than described in DT?
>
As much as we love everything to be runtime configurable, I am afraid i=
t
can't be. We can't add new calls to the dmaengine api for simply
supporting specific features of various dmacs (priority in this case)
Because that would mean ideally every client going through the mostly
useless ritual of querying/setting those features and most dmacs
just 'pretending' to support some, except for the rare ones that actual=
ly do.
So as much as these sound like policy, they would usually be directly
hardcoded via dt for the machine or deducted by the dmac driver.

>>
>>> client0: i2s {
>>> =A0 /* has 2 DMA request output signals: 0, 1 */
>>> };
>>>
>>> client1: spdif {
>>> =A0 /* has 2 DMA request signals: 0, 1 */
>>> };
>>>
>> Do we also need to somehow tag these signals for the client to
>> differentiate between TX and RX channel ?
>
> Yes, the client's DT binding would certainly need to describe how man=
y
> DMA request signals its HW generates, and give a unique ID to each. T=
he
> driver would need to request a DMA channel for a specific one of its =
DMA
> requests.
>
Did I read "give a unique ID to each" correctly ?
Could you please take some time out to jot down an example of how a
typical client's dma specifier should look.

=46WIW, I think I can live with what you propose. Let us go for the kil=
l.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
