From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: camera application for testing (was Re: v4l subdevs without big
 device)
Date: Sat, 30 Apr 2016 01:47:57 +0300
Message-ID: <5723E49D.1030104@gmail.com>
References: <20160428084546.GA9957@amd> <57230DE7.3020701@xs4all.nl>
 <20160429221359.GA29297@amd> <201604300020.58559@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201604300020.58559@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, patrikbachan@gmail.com, serge@hallyn.com, sakari.ailus@iki.fi, tuukkat76@gmail.com, mchehab@osg.samsung.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 30.04.2016 01:20, Pali Roh=C3=A1r wrote:
> On Saturday 30 April 2016 00:13:59 Pavel Machek wrote:
>> Any other application I should look at? Thanks,
>
> Maybe camera-ui, which is part of CSSU?
>
> https://github.com/community-ssu/camera-ui
>

This is based on gdigicam, are you sure it is compatible with recent=20
kernel/userspace? Also, iirc gdigicam needs omap3camd working, but we=20
still don't have the needed compat layer.

Ivo
