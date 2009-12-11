From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Thu, 10 Dec 2009 18:36:58 -0800
Message-ID: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2009 at 09:07:50PM +0100, Janusz Krzysztofik wrote:
> +
> +/*
> + * This table converts the amstrad mailboard scancodes to normal PC- 
> AT scancodes
> + * The diagram below shows the amstrad keyboard, with the raw  
> scancodes
> + *
> + *   (70) (7A) (46) (7C) (77)   Amstrad     (72) (69) (1A) (2A)  
> (1C) (15)
> + * [  71][1:74][2:73][3:6B][4:22][5:1B][6:1D][7:1E][8:79][9:7D] 
> [0:75][  6C]
> + *  [Q:21][W:23][E:24][R:26][T:52][Y:5D][U:0D][I:0E][O:32][P:34]  | 
> return|
> + *   [A:31][S:33][D:35][F:36][G:29][H:5B][J:03][K:76][L:3A][@:3B]   
> |   2C|
> + *  [  3C][Z:3D][X:4E][C:54][V:0B][B:05][N:41][M:42][.:43][  3E] 
> [  55]
> + *  [  83][  06][  49][           4B         ][,:44][  16][  2E] 
> [  09]
> + *
> + * These scancodes are then translated to AT scancodes using the  
> following table
> + * The amstrad keyboard does not produce any extended scancodes,  
> but we need to
> + * translate some amstrad scancodes to a AT extended scancode,  
> hence the 16bit
> + * value for the translated scancode
> + *

No, please write a proper keyboard driver instead of creating this
Frankenstain monster. It is not a generic serio-style data source so it
should not use serio, should reside in drivers/input/keyboard and create
input device by itself.

Thanks.

-- 
Dmitry
