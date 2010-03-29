From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Merge plans for Staging  Synaptics Touchscreen Driver
Date: Mon, 29 Mar 2010 17:45:40 +0530 (IST)
Message-ID: <49670.10.24.255.17.1269864940.squirrel@dbdmail.itg.ti.com>
References: <19039.10.24.255.18.1269336516.squirrel@dbdmail.itg.ti.com>   
    <20100326144415.GA1591@ucw.cz>
    <33474.10.24.255.18.1269863733.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <33474.10.24.255.18.1269863733.squirrel@dbdmail.itg.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>> Hi!
>>
>>> Are there any plans to merge the synaptics touchscreen driver
>>> (drivers/staging/dream/synaptics_i2c_rmi.c) to
>>> drivers/input/touchscreen. We are interested in the same
>>> since OMAP3 based Zoom boards use this touchscreen.
>>
>> Plans are, but day job interferes with them.
>>
>>> Pl add (if required) below tested by for the staging driver.
>
>>
>> 1) are you able to use driver in staging?
>
> Yes I am able to use staging driver for single
> touch events.
>
>>
>> at minimum, non-standard multitouch support needs to be removed before
>> merging to input. Do you have time to help?
>
> Could you review the below patch.

Forgot to remove unused variables in earlier patch, here's
the updated one.


---

Remove non-standard multi touch support.

Signed-off-by: Hemanth V <hemanthv@ti.com>

diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/staging/dream/synaptics_i2c_rmi.c
index 4de6bc9..f3bc7d6 100644
--- a/drivers/staging/dream/synaptics_i2c_rmi.c
+++ b/drivers/staging/dream/synaptics_i2c_rmi.c
@@ -108,9 +108,6 @@ static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
 	int f, a;
 	int base = 2;
 	int z = buf[1];
-	int w = buf[0] >> 4;
-	int finger = buf[0] & 7;
-	int finger2_pressed;

 	for (f = 0; f < 2; f++) {
 		u32 flip_flag = SYNAPTICS_FLIP_X;
@@ -150,14 +147,6 @@ static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
 		input_report_abs(ts->input_dev, ABS_Y, pos[0][1]);
 	}
 	input_report_abs(ts->input_dev, ABS_PRESSURE, z);
-	input_report_abs(ts->input_dev, ABS_TOOL_WIDTH, w);
-	input_report_key(ts->input_dev, BTN_TOUCH, finger);
-	finger2_pressed = finger > 1 && finger != 7;
-	input_report_key(ts->input_dev, BTN_2, finger2_pressed);
-	if (finger2_pressed) {
-		input_report_abs(ts->input_dev, ABS_HAT0X, pos[1][0]);
-		input_report_abs(ts->input_dev, ABS_HAT0Y, pos[1][1]);
-	}
 	input_sync(ts->input_dev);
 }




