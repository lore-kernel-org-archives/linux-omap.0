From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: hwmod: AM33xx/43xx: Add HWMOD_INIT_NO_IDLE
 flag to tptc
Date: Mon, 2 Nov 2015 14:49:22 +0200
Message-ID: <56375BD2.9050107@ti.com>
References: <1446459060-16220-1-git-send-email-peter.ujfalusi@ti.com>
 <20151102102440.GM21326@localhost> <5637398C.6020000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5637398C.6020000-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/02/2015 12:23 PM, Peter Ujfalusi wrote:
> On 11/02/2015 12:24 PM, Vinod Koul wrote:
>> On Mon, Nov 02, 2015 at 12:11:00PM +0200, Peter Ujfalusi wrote:
>>> In Linux we do not have driver for TPTCs of eDMA3 since there is no=
 need to
>>> do any configuration within TPTC for the eDMA3 to be operational. A=
ll
>>> configuration is via the TPCC.
>>> To prevent the omap_device_late_idle() to disable the TPTCs when th=
ey are
>>> no longer bind with the edma driver, the HWMOD_INIT_NO_IDLE need to=
 be
>>> added.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
>>> ---
>>> Vinod, Olof,
>>>
>>> This patch somehow got lost in my working branch. It was mixed with=
in the patches
>>> I will have for 4.5 while it should have been within the new eDMA3 =
binding
>>> series..
>>
>> Does this fix the issue reported by Olof? Also ACK pls for this
>=20
> Yes, it is fixing the issue, I have this in my branch. everything loo=
ks fine
> on AM335x/AM437x/Dra7xx where I have eDMA in use.

Vinod, can you please ignore this patch? I'm going to send a patch agai=
ns
edma.c which will handle this better.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
