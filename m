From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host bus-suspend/resume
Date: Thu, 11 Jan 2018 11:04:24 +0200
Message-ID: <87d12gydev.fsf@linux.intel.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org> <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com> <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org> <87r2qwyfp9.fsf@linux.intel.com> <a30be8a0-63ee-da02-f7a2-4958b7ee35bf@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a30be8a0-63ee-da02-f7a2-4958b7ee35bf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manu Gautam <mgautam@codeaurora.org>, Roger Quadros <rogerq@ti.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Manu Gautam <mgautam@codeaurora.org> writes:
>>>> On 27/09/17 14:19, Manu Gautam wrote:
>>>>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>>>>> resume. While this works fine for gadget mode but in host
>>>>> mode there is not re-initialization of host stack. Also, resetting
>>>>> bus as part of bus_suspend/resume is not correct which could affect
>>>>> (or disconnect) connected devices.
>>>>> Fix this by not reinitializing core on suspend/resume in host mode
>>>>> for HOST only and OTG/drd configurations.
>>>>>
>>>> All this seems correct but we (TI) were relying on dwc3_core_exit() to=
 be called
>>>> during dwc3_suspend() to have the lowest power state for our platforms.
>>>>
>>>> After this patch, DWC3 controller and PHYs won't be turned off thus
>>>> preventing our platform from reaching low power levels.
>>>>
>>>> So this is a regression for us (TI) in v4.15-rc.
>>>>
>>>> Felipe, do you agree?
>>>>
>>>> If yes I can send a patch which fixes the regression
>>>> and also makes USB host work after suspend/resume.
>>>>
>>> I think it will be better to separate runtime_suspend and pm_suspend ha=
ndling for
>>> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across=
 system
>>> suspend-resume should be ok but doing that for runtime suspend-resume i=
s not
>>> correct.
>> it sure is. It's part of hibernation-while-disconnected programming sequ=
ence
>>
>>> Let me know if that sounds ok, I can provide a patch for same instead of
>>> reverting this which affects runtime PM with dwc3 host.
>> nope, that would break platforms using hibernation
>
> Please don't mind me asking this if it is very basic, I am probably
> missing something there
>
> We should be able to distinguish between runtime_pm vs
> system_suspend/hibernation and then process accordingly.

I'm not talking about Linux suspend to disk; I'm talking about Synopsys'
Hibernation feature (open up your databook and have a read ;-)

> In host mode runtime suspend/resume could happen very often with
> device connected, and resetting h/w on every runtime_resume might not
> be desired. And PHYs drivers can also support runtime_suspend which
> would be preferred instead of shutting down phy.

We don't do anything when dwc3 is working as a host, we simply assume if
we reach dwc3.ko, xhci has done its part. Here's what our
suspend_common looks like:

static int dwc3_suspend_common(struct dwc3 *dwc)
{
	unsigned long	flags;

	switch (dwc->current_dr_role) {
	case DWC3_GCTL_PRTCAP_DEVICE:
		spin_lock_irqsave(&dwc->lock, flags);
		dwc3_gadget_suspend(dwc);
		spin_unlock_irqrestore(&dwc->lock, flags);
		dwc3_core_exit(dwc);
		break;
	case DWC3_GCTL_PRTCAP_HOST:
	default:
		/* do nothing */
		break;
	}

	return 0;
}

We're not resetting anything, not tearing down anything. No idea why
you're saying that in host mode we're breaking things apart. If you have
out-of-tree patches on top of v4.15-rc7, fix them instead of claiming
mainline is at fault.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlpXKJgACgkQzL64meEa
mQYBNA//ZIG8sBrmOtO1VnzDQlQ6nM/BZM4D+wnZ6Tgvk8TJje9oQ6vzzoL3t3dp
pICs0nF/RoJ0UFDiSWQiC3pep1gu60AII2u0dq3KZD+QxDP+SLLg/al0OuCwS1vW
q0WBRagexjbIRRluW9/gqNpcK5XLiMenvClf0VPtZ43+ktN3fkZx6wHPwVGskz2X
VUNV0GSPf/YuAxQra2ASipcMRE20gJ6jwDnzYD4f+8VjAC61nDjvP8U18Yvp4KWr
RKny0ZnLiyD/7tAB1MBnsBWu2+XWEojd5Pb6A/xzRjKMtEbWy8sSjek0n1r+An3P
pkC9rqmRWCVIA8VlyTbbqudWhJBsgBnw97slBtoB9dYu958NubhaDiVvgK1yqLFA
x26A2IDxQ1lwdKaIsDu7ib661ln5b4NHCoOJSieHodjktzJlzUVh5x6op2VZ09SA
Ubusd3pAIVFjvcqTi3eZ4UBfa3VfMDWL0wqMLXvPwyqYm/hXj8HK+Qig/Y7r53gf
+bwUfbG9Tp3l/bDffiQtPnfddt1j/ToVA0JTagvu3q6n9dqkVe6TyTgsqwJwSJje
oWVuEn2Te374bAJ8fKaT+9iNgrT4+cnFxnpcxTAG5D1OtUQ4AZaa62C98EN0QRPz
MTNe0CCBE3NLwtwWoSl3qkymCCXNJw0IiNWQZ+4uA6CB4Wm2/60=
=xcB1
-----END PGP SIGNATURE-----
--=-=-=--
