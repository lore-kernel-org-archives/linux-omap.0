From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Linux Plumbers Conference 2009: V4L2 API discussions
Date: Tue, 4 Aug 2009 09:12:24 +0200
Message-ID: <200908040912.24718.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Dongsoo, Nathaniel Kim" <dongsoo.kim@gmail.com>, eduardo.valentin@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi all,

During this years Plumbers Conference I will be organizing a session (or
possibly more than one) on what sort of new V4L2 APIs are needed to
support the new SoC devices. These new APIs should also solve the problem
of how to find all the related alsa/fb/ir/dvb devices that a typical video
device might create.

A proposal was made about a year ago (note that this is a bit outdated
by now, but the basics are still valid):

http://www.archivum.info/video4linux-list%40redhat.com/2008-07/msg00371.html

In the past year the v4l2 core has evolved enough so that we can finally
start thinking about this for real.

I would like to know who will be attending this conference. I also urge
anyone who is working in this area and who wants to have a say in this to
attend the conference. The goal is to prepare a new RFC with a detailed
proposal on the new APIs that are needed to fully support all the new
SoCs. So the more input we get, the better the end-result will be.

Early-bird registration is still possible up to August 5th (that's
tomorrow :-) ).

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
