From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RFC] Updated 3430SDP and LDP camera drivers
Date: Tue, 21 Apr 2009 18:33:32 -0500
Message-ID: <A24693684029E5489D1D202277BE89442EEB5F08@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

I have created a gitorious account for storing latest progress on 3430SDP and LDP camera sensor drivers. (MT9P012 and OV3640 for SDP, and OV3640 for LDP)

This patchset can be pulled with the following command:

git pull git://git.gitorious.org/omap3-linux-camera-driver/mainline.git omap3camerabase 3430sdp_and_ldp_sensor_drivers

It is based on 2.6.30-rc2

Notes:

- omap3camerabase branch contains a snapshot of almost all the commits shared through Sakari's gitorious repository (http://www.gitorious.org/projects/omap3camera). The only commits lacking are the ones that had been accepted already on mainline/linux-omap.

- 3430sdp_and_ldp_sensor_drivers: Contains the patches I have been sharing during the past months but with some fixes done already based on the comments many of you have provided (Thanks a lot for that)

Known TODOs:

- v4l2_subdev conversion!
- ISP xclk exported to Clock API
- Memory 2 memory device conversion
- Syncup with latest internal tree fixes
- Use regulator framework
- Fix OV3640 (at least on SDP doesn't work now somehow)

As soon as I update them, will let you know. Any comment on those, is completely welcome.

Regards,
Sergio
