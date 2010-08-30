From: Felipe Balbi <me@felipebalbi.com>
Subject: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2] input: CMA3000
 Accelerometer driver)
Date: Mon, 30 Aug 2010 11:04:39 -0500
Message-ID: <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com> <20100829184904.GC26209@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100829184904.GC26209@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, igor.stoppa@nokia.com, kai.svahn@nokia.com, matthias.nyman@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

When we tried to push N900's accelerometer driver as an
input device you commented you didn't want sensors such
as accelerometers, magnetometers, proximity, etc on the
input layer because "they are not user input", although
I didn't fully agree with you, we had to modify the drivers
and, I believe, one of them is sitting in staging under
the industrial i/o subsystem.

Are you now accepting sensor drivers on the input layer ?
that will make our life a lot easier but we need some
definition to avoid having to re-work drivers when we
want to push them to mainline.

-- 
balbi
