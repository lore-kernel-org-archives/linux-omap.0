From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 2/4] OMAPDSS: HDMI: update static timing table
Date: Wed, 16 Nov 2011 10:43:22 +0530
Message-ID: <CAP5A+B_snSLSU07JbnTGGpfcnVpWvkQnAGkYQz2S8AWp8_Zm6w@mail.gmail.com>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
 <1321016977-1808-2-git-send-email-mythripk@ti.com> <1321016977-1808-3-git-send-email-mythripk@ti.com>
 <1321255238.1931.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog004.obsmtp.com ([74.125.150.48]:43312 "EHLO
	na6sys009bog004.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482Ab1KPFSu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 00:18:50 -0500
Received: by ggnp1 with SMTP id p1so5389378ggn.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 21:18:49 -0800 (PST)
In-Reply-To: <1321255238.1931.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Mon, Nov 14, 2011 at 12:50 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add the vsync polarity, hsync polarity, interlace to hdmi_video_timi=
ngs.
>> Remove the now duplicate structure hdmi_timings.
>> update the static table structure in HDMI with CEA/VESA code and mod=
e.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 96 ++=
++++++++++++--------------
>> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 | =A0 14 ++---
>> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | =A0 20 +++---
>> =A03 files changed, 63 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index c56378c..f76ae47 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -88,42 +88,42 @@ static struct {
>> =A0 * map it to corresponding CEA or VESA index.
>> =A0 */
>>
>> -static const struct hdmi_timings cea_vesa_timings[OMAP_HDMI_TIMINGS=
_NB] =3D {
>> - =A0 =A0 { {640, 480, 25200, 96, 16, 48, 2, 10, 33} , 0 , 0},
>> - =A0 =A0 { {1280, 720, 74250, 40, 440, 220, 5, 5, 20}, 1, 1},
>> - =A0 =A0 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1},
>> - =A0 =A0 { {720, 480, 27027, 62, 16, 60, 6, 9, 30}, 0, 0},
>> - =A0 =A0 { {2880, 576, 108000, 256, 48, 272, 5, 5, 39}, 0, 0},
>> - =A0 =A0 { {1440, 240, 27027, 124, 38, 114, 3, 4, 15}, 0, 0},
>> - =A0 =A0 { {1440, 288, 27000, 126, 24, 138, 3, 2, 19}, 0, 0},
>> - =A0 =A0 { {1920, 540, 74250, 44, 528, 148, 5, 2, 15}, 1, 1},
>> - =A0 =A0 { {1920, 540, 74250, 44, 88, 148, 5, 2, 15}, 1, 1},
>> - =A0 =A0 { {1920, 1080, 148500, 44, 88, 148, 5, 4, 36}, 1, 1},
>> - =A0 =A0 { {720, 576, 27000, 64, 12, 68, 5, 5, 39}, 0, 0},
>> - =A0 =A0 { {1440, 576, 54000, 128, 24, 136, 5, 5, 39}, 0, 0},
>> - =A0 =A0 { {1920, 1080, 148500, 44, 528, 148, 5, 4, 36}, 1, 1},
>> - =A0 =A0 { {2880, 480, 108108, 248, 64, 240, 6, 9, 30}, 0, 0},
>> - =A0 =A0 { {1920, 1080, 74250, 44, 638, 148, 5, 4, 36}, 1, 1},
>> - =A0 =A0 /* VESA From Here */
>> - =A0 =A0 { {640, 480, 25175, 96, 16, 48, 2 , 11, 31}, 0, 0},
>> - =A0 =A0 { {800, 600, 40000, 128, 40, 88, 4 , 1, 23}, 1, 1},
>> - =A0 =A0 { {848, 480, 33750, 112, 16, 112, 8 , 6, 23}, 1, 1},
>> - =A0 =A0 { {1280, 768, 79500, 128, 64, 192, 7 , 3, 20}, 1, 0},
>> - =A0 =A0 { {1280, 800, 83500, 128, 72, 200, 6 , 3, 22}, 1, 0},
>> - =A0 =A0 { {1360, 768, 85500, 112, 64, 256, 6 , 3, 18}, 1, 1},
>> - =A0 =A0 { {1280, 960, 108000, 112, 96, 312, 3 , 1, 36}, 1, 1},
>> - =A0 =A0 { {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38}, 1, 1},
>> - =A0 =A0 { {1024, 768, 65000, 136, 24, 160, 6, 3, 29}, 0, 0},
>> - =A0 =A0 { {1400, 1050, 121750, 144, 88, 232, 4, 3, 32}, 1, 0},
>> - =A0 =A0 { {1440, 900, 106500, 152, 80, 232, 6, 3, 25}, 1, 0},
>> - =A0 =A0 { {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30}, 1, 0},
>> - =A0 =A0 { {1366, 768, 85500, 143, 70, 213, 3, 3, 24}, 1, 1},
>> - =A0 =A0 { {1920, 1080, 148500, 44, 148, 80, 5, 4, 36}, 1, 1},
>> - =A0 =A0 { {1280, 768, 68250, 32, 48, 80, 7, 3, 12}, 0, 1},
>> - =A0 =A0 { {1400, 1050, 101000, 32, 48, 80, 4, 3, 23}, 0, 1},
>> - =A0 =A0 { {1680, 1050, 119000, 32, 48, 80, 6, 3, 21}, 0, 1},
>> - =A0 =A0 { {1280, 800, 79500, 32, 48, 80, 6, 3, 14}, 0, 1},
>> - =A0 =A0 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1}
>> +static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_=
NB] =3D {
>> +{ {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI}=
 },
>> +{ {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} =
},
>> +{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDM=
I} },
>> +{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15, 1, 1, 1}, {5, HDMI_HDMI=
} },
>> +{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15, 0, 0, 1}, {6, HDMI_HDM=
I} },
>> +{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36, 1, 1, 0}, {16, HDMI_H=
DMI} },
>> +{ {720, 576, 27000, 64, 12, 68, 5, 5, 39, 0, 0, 0}, {17, HDMI_HDMI}=
 },
>> +{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20, 1, 1, 0}, {19, HDMI_HD=
MI} },
>> +{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15, 1, 1, 1}, {20, HDMI_HD=
MI} },
>> +{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19, 0, 0, 1}, {21, HDMI_HD=
MI} },
>> +{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39, 0, 0, 0}, {29, HDMI_HD=
MI} },
>> +{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36, 1, 1, 0}, {31, HDMI_=
HDMI} },
>> +{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_H=
DMI} },
>> +{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_H=
DMI} },
>> +{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_H=
DMI} },
>> +/* VESA From Here */
>> +{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI}=
 },
>> +{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI}=
 },
>> +{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23, 1, 1, 0}, {0xE, HDMI_D=
VI} },
>> +{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20, 1, 0, 0}, {0x17, HDMI=
_DVI} },
>> +{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22, 1, 0, 0}, {0x1C, HDMI=
_DVI} },
>> +{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18, 1, 1, 0}, {0x27, HDMI=
_DVI} },
>> +{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36, 1, 1, 0}, {0x20, HDM=
I_DVI} },
>> +{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38, 1, 1, 0}, {0x23, HD=
MI_DVI} },
>> +{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29, 0, 0, 0}, {0x10, HDMI_=
DVI} },
>> +{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32, 1, 0, 0}, {0x2A, HDM=
I_DVI} },
>> +{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25, 1, 0, 0}, {0x2F, HDMI=
_DVI} },
>> +{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30, 1, 0, 0}, {0x3A, H=
DMI_DVI} },
>> +{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24, 1, 1, 0}, {0x51, HDMI_=
DVI} },
>> +{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36, 1, 1, 0}, {0x52, HDMI=
_DVI} },
>> +{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12, 0, 1, 0}, {0x16, HDMI_DV=
I} },
>> +{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23, 0, 1, 0}, {0x29, HDMI_=
DVI} },
>> +{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21, 0, 1, 0}, {0x39, HDMI_=
DVI} },
>> +{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14, 0, 1, 0}, {0x1B, HDMI_DV=
I} },
>> +{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_=
DVI} }
>
> If you don't have any particular reason to use both decimal and
> hexadecimal numbers for code, just use one type of numbers.
>
The reason being this is coding convention in CEA and VESA spec, so
wanted to keep it uniform with the spec.
Thanks and regards,
Mythri.
> =A0Tomi
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
