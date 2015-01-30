From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Fri, 30 Jan 2015 14:43:08 +0200
Message-ID: <54CB7C5C.9000807@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd> <54C63F1C.6010703@ti.com> <54C92752.9000004@bitmer.com> <20150128224144.GA28956@amd> <20150129073529.GA19122@bitmer.com> <54CA173F.1070301@ti.com> <20150130102639.GA19595@amd> <20150130103748.GA24623@amd> <54CB7BA6.2070408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52099 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbbA3MoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2015 07:44:04 -0500
In-Reply-To: <54CB7BA6.2070408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, lars@metafoo.de, misael.lopez@ti.com

On 01/30/2015 02:40 PM, Peter Ujfalusi wrote:
> On 01/30/2015 12:37 PM, Pavel Machek wrote:
>> Hi!
>>
>>> I looked around the diff between 3.18 and 3.19, reverted these, and
>>> audio quality is back to reasonable level.
>>
>> Actually, reverting 368494093354ac613a80c2e1d77602aa12473cf0 seems
>> enough.
>>
>> Any quick patches to test? Or should we revert so that 3.19-final
>> works ok?
>=20
> I'll send the fix in a minute, thanks for finding it ;)

And here it is:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/08722=
8.html

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
