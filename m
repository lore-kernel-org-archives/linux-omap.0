From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/3] dt/binding: ti-tsc-adc: deprecate ti,charge-delay and add binding doc for ti,charge-delay-ns
Date: Thu, 10 Nov 2016 22:05:13 +0530
Message-ID: <20161110163515.27598-2-mugunthanvnm@ti.com>
References: <20161110163515.27598-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161110163515.27598-1-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ti,charge-delay represents the duration that ADC should wait
before sampling the ADC line to detect the touch location and pen
up/downs. Currently the ADC clock is set at 3MHz. The device-tree
entry for ti,charge-delay is based on assumption of ADC clock at
3MHz, but it can be operated up to 24MHz clock. Representing the
charge delay of touchscreen in terms of ADC clocks is incorrect.
So change this representation to ti,charge-delay-ns, which driver
can convert it to number clock cycles based on ref clock
frequency.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      | 32 ++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index b1163bf97146..83570776c804 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -30,17 +30,27 @@ Required properties:
 
 Optional properties:
 - child "tsc"
-	ti,charge-delay: Length of touch screen charge delay step in terms of
-			 ADC clock cycles. Charge delay value should be large
-			 in order to avoid false pen-up events. This value
-			 effects the overall sampling speed, hence need to be
-			 kept as low as possible, while avoiding false pen-up
-			 event. Start from a lower value, say 0x400, and
-			 increase value until false pen-up events are avoided.
-			 The pen-up detection happens immediately after the
-			 charge step, so this does in fact function as a
-			 hardware knob for adjusting the amount of "settling
-			 time".
+	ti,charge-delay-ns: Length of touch screen charge delay step in terms of
+			    nano Seconds. Charge delay value should be large
+			    in order to avoid false pen-up events. This value
+			    effects the overall sampling speed, hence need to be
+			    kept as low as possible, while avoiding false pen-up
+			    event. Start from a lower value, say 41000nS, and
+			    increase value until false pen-up events are avoided.
+			    The pen-up detection happens immediately after the
+			    charge step, so this does in fact function as a
+			    hardware knob for adjusting the amount of "settling
+			    time".
+	ti,charge-delay: Deprecated as representing charge delay should be
+			 represented in time as the ADC clock may be different.
+			 Currently this value is calculated based on 3MHz ADC
+			 ref clock, but ADC clock can operate upto 24MHz clock.
+			 ADC clock will be changed to 24MHz to increase the
+			 number of ADC samples. So to keep the backward
+			 compatibility, driver will consider this value is
+			 calculated for 3MHz clock so the value will be
+			 multiplied by 8 to compensate the change in reference
+			 clock.
 
 - child "adc"
 	ti,chan-step-opendelay: List of open delays for each channel of
-- 
2.11.0.rc0.7.gbe5a750

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
