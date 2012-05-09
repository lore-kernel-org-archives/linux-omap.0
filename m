From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 10 May 2012 03:08:57 +0530
Message-ID: <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42918 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932440Ab2EIVi7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:38:59 -0400
Received: by lahd3 with SMTP id d3so584632lah.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 14:38:57 -0700 (PDT)
In-Reply-To: <4FAAC111.9020308@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 10 May 2012 00:40, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/08/2012 01:09 PM, Jassi Brar wrote:
>>
>> There is important difference between providing data via clients
>> during runtime vs providing info about every client to the dmac driv=
er
>> at one go during its probe.
>
> I certainly see that there is a difference.
>
> I don't understand why it's an important difference; I think everythi=
ng
> needs to be handled at run-time no matter what:
>
> Just because there is information in the DT that "this client DT node
> uses this channel/request-ID/... of this DMA controller" doesn't mean
> that the driver for the client is going to be loaded, or that SW runn=
ing
> on the system is going to cause that driver to actually be opened and=
 do
> any DMA. As such, any resource allocation rules etc. must be evaluate=
d
> only if/when a driver actually requests/uses a DMA channel, so having
> "all the information up front" doesn't seem like a theoretically
> possible thing anyway.
>
One point is about 'qos' here.... something like bandwidth allocation.
If the dmac driver knew up-front the max possible clients that could be
active simultaneously, it could "divide the bandwidth" accordingly.
Again, the example of PL330 employing 2physical channels for better
service - LLI (you got it right), where even 1 physical channel would
also have served only not as reliably. I believe there would be
more such scenarios.

Another minor benefit could be that the dmac driver populate only
as many "struct dma_chan" as there are actually clients on the
machine (and this population has to be done during probe).
It could mean ~8 instead of ~40 channels populated on a machine.
Note, a PL330 dmac can have 32 channels, OMAP's has 128....

Most importantly, I just think it's a cleaner approach.


> Very similar to this, in order to support your point that a given cli=
ent
> could potentially use a channel from either of 2 different DMA
> controller instances, you don't know until run-time which controller
> will be used, so can't have up-front information in this scenario
> either, even if the DMA does actually take place.
>
Sorry, perhaps I wasn't clear enough.
A client sees _no_ difference between the two channels that could serve=
 it.
And it can't start using two, if two are available.
Client just needs one suitable channel on whichever dmac that might be.
If the channel for a client is to be switched runtime, that decision
should lie with the dmac driver, not the client. And I am not really
after implementing that runtime decision support.


> Solving (b) seems to require something very roughly like:
>
> dma-controller@0 {
> =A0 =A0compatible =3D "foo,dmac-xxx";
> =A0 =A0dma-requests =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client0 0 // DMAC req 0 is client0's =
0th req output
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client0 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client1 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client1 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client2 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...>;
> };
>
> dma-controller@1 {
> =A0 =A0compatible =3D "bar,dmac-yyy";
> =A0 =A0dma-requests =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0// Supports some client modules, but n=
ot the same ones
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client1 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&client3 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...>;
> };
>
> client0: i2s {
> =A0 =A0/* has 2 DMA request output signals: 0, 1 */
> };
>
> client1: spdif {
> =A0 =A0/* has 2 DMA request signals: 0, 1 */
> };
>
> client2: foo {
> =A0 =A0/* has 1 DMA request signal: 0 */
> };
>
> client3: bar {
> =A0 =A0/* has 1 DMA request signal: 0 */
> };
>
> and then having the core DMA code have an API like:
>
> channel =3D dma_request(clients_dma_req_output_id)
>
> which looks in each DMA controller's dma-requests list for the client=
's
> phandle and matching dma_req_output_id.
>
Almost what I proposed in my third post in this thread !!

The minor difference being, you use the {request-signal, phandle} pair
to find the right channel, I used only 'token'.

Please note, with this method we specify info about every client at one
go and via dmac's DT node - hence those benefits.

Also note that, a client's dma specifier becomes perfectly general
and future-proof
   client1: spdif {
          dma_tx =3D <278>
          dma_rx =3D <723>
    };

otherwise the following representation
    client1: spdif {
               dma =3D <&sdma 2 1 &sdma 3 2>;
     };
could break with some weird dma setups (IIANW Russell already finds
it wouldn't work for him).

I am arguing for (b) for the above mentioned reasons, and not because
I want to have clients switching channels in runtime.

Thanks,
Jassi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
