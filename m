From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v4 10/11] OMAP: Serial: Allow UART parameters to be
 configured from board file.
Date: Mon, 12 Sep 2011 12:04:41 +0530
Message-ID: <CAAL8m4x6uNKu9tTxj8L4HkrsFhigJ_mxOg+NMGcAk__aCg8VZA@mail.gmail.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
 <1315400013-4849-11-git-send-email-govindraj.raja@ti.com> <87zkidtttm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87zkidtttm.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, Partha Basak <p-basak2@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2011 at 12:41 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> The following UART parameters are defined within the UART driver:
>>
>> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
>> 2). The size of dma buffer (set to 4096 bytes)
>> 3). The time after which the dma should stop if no more data is rece=
ived.
>> 4). The auto suspend delay that will be passed for pm_runtime_autosu=
spend
>> =A0 =A0 where uart will be disabled after timeout
>>
>> Different UARTs may be used for different purpose such as the consol=
e,
>> for interfacing bluetooth chip, for interfacing to a modem chip, etc=
=2E
>> Therefore, it is necessary to be able to customize the above setting=
s
>> for a given board on a per UART basis.
>>
>> This change allows these parameters to be configured from the board =
file
>> and allows the parameters to be configured for each UART independent=
ly.
>>
>> If a board does not define its own custom parameters for the UARTs, =
then
>> use the default parameters in the structure "omap_serial_default_inf=
o".
>> The default parameters are defined to be the same as the current set=
tings
>> in the UART driver to avoid breaking the UART for any board. By defa=
ult,
>> make all boards use the default UART parameters.
>>
>> Signed-off-by: Deepak K <deepak.k@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Who is the author of this patch? =A0The first version says Jon[1], v2=
 says
> Deepak[2]. =A0Either way, please ensure proper authorship is attribut=
ed
> using From: at the beginning of the changelog. =A0(git-format-patch w=
ill
> do this for you when the authorship is correct in the git history.)
>
> Even better would be to summarize the changes since the first version
> after the '---' so it would be clearer why the authorship was changed=
=2E
>
> Only 1/3 of my comments from v3 were addressed in this version. =A0Pl=
ease
> re-read my comments there[3].
>

Will fix this and repost.

--
Thanks,
Govindraj.R


> Kevin
>
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D129890257812478&w=3D2
> [2] http://marc.info/?l=3Dlinux-omap&m=3D130408096416887&w=3D2
> [3] http://marc.info/?l=3Dlinux-omap&m=3D130896078622810&w=3D2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
