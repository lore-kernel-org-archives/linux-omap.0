From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC/PATCHv2 5/5] arm: omap2+: omap_device: remove no_idle_on_suspend
Date: Tue, 23 Apr 2013 09:13:39 +0200
Message-ID: <517634A3.30104@ti.com>
References: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com> <1366638237-6880-6-git-send-email-sourav.poddar@ti.com> <20130422143839.GE7508@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130422143839.GE7508@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>, gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra nayak <rnayak@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 04/22/2013 04:38 PM, Felipe Balbi wrote:
>> Is it possible to handle ABE no_idle_on_suspend uscase the way I am
>> trying to handle it for UART in the 2nd patch of this series?=20
>=20
> let's ask P=E9ter.
>=20
> P=E9ter, OMAP_DEVICE_NO_IDLE_ON_SUSPEND should be removed as driver's=
 can
> get same behavior by just returning -EBUSY from their ->runtime_suspe=
nd
> callbacks. Do you see any problems with patch below (left for
> reference) ? Would it be too difficult to add
> ->runtime_suspend/->runtime_resume on ASoC layer ?

I don't see any issue with this. FWIW AESS/ABE does not use the
OMAP_DEVICE_NO_IDLE_ON_SUSPEND flag neither in upstream nor in my devel=
opment
branch.

--=20
P=E9ter
