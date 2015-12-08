From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Tue, 8 Dec 2015 09:43:13 +0200
Message-ID: <56668A11.3000408@ti.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <20151208001943.GT23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151208001943.GT23396-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/08/2015 02:19 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [151204 02:46]:
>> +
>> +			ti,tptcs =3D <&edma_tptc0 7>, <&edma_tptc1 5>,
>> +				   <&edma_tptc2 0>;
>> +
>> +			ti,edma-memcpy-channels =3D /bits/ 16 <20 21>;
>=20
> Is this safe to change to just ti,edma-memcpy-channels =3D <20 21> as
> suggested by Arnd?

The binding document for the eDMA and the driver also needs update to b=
e able
to handle this change.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
